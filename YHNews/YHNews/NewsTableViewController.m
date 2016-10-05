//
//  NewsTableViewController.m
//  YHNews
//
//  Created by 闫合 on 16/8/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "NewsTableViewController.h"
#import "YHNews.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "ShowViewController.h"
#import "MJRefresh.h"
@interface NewsTableViewController ()
{
    NSMutableArray *btns;
    NSMutableArray *news;
    ShowViewController *show;
    
    
}
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation NewsTableViewController
-(IBAction)btnTap:(UIButton *)sender
{
    for (int i=0; i<5; i++)
    {
        UIButton *btn = [btns objectAtIndex:i];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    sender.titleLabel.font = [UIFont systemFontOfSize:20];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSInteger flid = sender.tag;
    Reachability *reach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    NetworkStatus status =   reach.currentReachabilityStatus;
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if (status==NotReachable)
    {
        //从本地加载数据
        [self loadLocalData];
    }
    else
    {   //有网络，从远端加载数据
        [self loadDataWithId:flid];
    }
    [SVProgressHUD dismissWithDelay:0.1];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    btns = [NSMutableArray arrayWithObjects:_newsBtn,_guoneiBtn,_guojiBtn,_shehuiBtn,_gongyiBtn, nil];
    _newsBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_newsBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    news = [[NSMutableArray alloc]initWithCapacity:1000];
    Reachability *reach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    NetworkStatus status =   reach.currentReachabilityStatus;
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if (status==NotReachable)
    {
        //从本地加载数据
        [self loadLocalData];
    }
    else
    {   //有网络，从远端加载数据
        [self loadDataWithId:1];
    }
    [SVProgressHUD dismiss];
    //增加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(RefreshTap)];
    //增加上拉加载
    [self.tableView addFooterWithTarget:self action:@selector(loadTap)];
}
-(void)RefreshTap
{
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}
-(void)loadTap
{
    [self.tableView reloadData];
    [self.tableView footerEndRefreshing];
}

#pragma mark - 从远端加载数据
-(void)loadDataWithId:(NSInteger)flid
{
    [news removeAllObjects];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    FMDatabase *db = app.db;
    [db executeUpdate:@"delete from news"];//清空数据
    NSString *strUrl = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/getnews.php?id=%ld",flid];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data)
    {
        //解析数据
        NSArray *newsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (newsArray.count>0)
        {
            for (NSDictionary *dict in newsArray)
            {
                YHNews *xinwen = [[YHNews alloc]init];
                NSArray *keys = [dict allKeys];
                for (NSString *key in keys)
                {
                    [xinwen setValue:[dict objectForKey:key] forKey:key];
                }
                NSString *imgName = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/images/%@",xinwen.picture];
                NSURL *url = [NSURL URLWithString:imgName];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                xinwen.img = [UIImage imageWithData:data];
                [news addObject:xinwen];
                BOOL b = [db executeUpdate:@"insert into news(idid,title,subtitle,picture,content,author,flid,time,clicks,pic) values(?,?,?,?,?,?,?,?,?,?)",xinwen.idid,xinwen.title,xinwen.subtitle,xinwen.picture,xinwen.content,xinwen.author,xinwen.flid,xinwen.time,xinwen.clicks,data];
                if (!b)
                {
                    NSLog(@"insert data error!");
                }
            }
        }
        [self.tableView reloadData];
    }
    else
    {
        //创建一个警报
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"加载新闻失败，请稍后再试！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
#pragma mark - 从本地加载数据
-(void)loadLocalData
{
    [news removeAllObjects];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    FMDatabase *db = app.db;
   FMResultSet *rs = [db executeQuery:@"select * from news"];

    while (rs.next)
    {
        YHNews *myNews = [[YHNews alloc]init];
        myNews.idid = [NSNumber numberWithInt:[rs intForColumn:@"idid"]];
        myNews.title = [rs stringForColumn:@"title"];
        myNews.subtitle = [rs stringForColumn:@"subtitle"];
        myNews.picture = [rs stringForColumn:@"picture"];
        myNews.content = [rs stringForColumn:@"content"];
        myNews.author = [rs stringForColumn:@"author"];
        myNews.time = [rs stringForColumn:@"time"];
        myNews.flid = [NSNumber numberWithInt:[rs intForColumn:@"flid"]];
        myNews.clicks = [NSNumber numberWithInt:[rs intForColumn:@"clicks"]];
        myNews.img = [UIImage imageWithData:[rs dataForColumn:@"pic"]];
        [news addObject:myNews];
    }

}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return news.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell01" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell01"];
    }
    YHNews *myNews = news[indexPath.row];
    cell.textLabel.text = myNews.title;
    cell.detailTextLabel.text = myNews.subtitle;
    cell.imageView.image = myNews.img;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    show = [segue destinationViewController];
    show.news = news[_indexPath.row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [self performSegueWithIdentifier:@"show" sender:self];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
