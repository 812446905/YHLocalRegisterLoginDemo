//
//  SearchViewController.m
//  YHNews
//
//  Created by 闫合 on 16/8/3.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "SearchViewController.h"
#import "YHNews.h"
#import "ShowViewController.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
@interface SearchViewController ()
@property (nonatomic,strong) ShowViewController *show;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _news = [[NSMutableArray alloc]initWithCapacity:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SearchTap:(id)sender
{
   // NSLog(@"search go");
    [_news removeAllObjects];
    NSString *str = _searchText.text;
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length==0)
    {
        //创建一个警报
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"你要搜索的内容不能为空！"preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        _searchText.text = @"";
        [_searchText becomeFirstResponder];
        return;
    }
    Reachability *reach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    NetworkStatus status = reach.currentReachabilityStatus;
    if (status==NotReachable)
    {
        //没有网络
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"没有有效的网络连接，无法进行搜索操作！"preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {   //有网络，从远端加载数据
        NSURL *url = [NSURL URLWithString:@"http://115.159.1.248:56666/xinwen/getsearchs.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"post"];
        NSString *strSearch = [NSString stringWithFormat:@"content=%@",str];
        [request setHTTPBody:[strSearch dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (data!=nil)
        {
            //对数据进行解析
            NSArray *newsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (newsArray==nil)
            {
                //创建一个警报
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"对不起，没有找到搜索的内容！" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            if (newsArray.count>0)//如果有数据
            {
                for (NSDictionary *dict in newsArray)
                {
                    NSArray *keys = [dict allKeys];
                    YHNews *xinwen = [[YHNews alloc]init];
                    for (NSString *key in keys)
                    {
                        //对对象的属性一一赋值kvc
                        [xinwen setValue:[dict objectForKey:key] forKey:key];
                    }
                    
                    NSString *imgName = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/images/%@",xinwen.picture];
                    NSURL *url = [NSURL URLWithString:imgName];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                    xinwen.img = [UIImage imageWithData:data];
                    //加到news集合
                    [_news addObject:xinwen];
                }
                
            }
        }
    }
    [self.tableView reloadData];

    [self.view endEditing:YES];
}

- (IBAction)closeKB:(id)sender {
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _news.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell03"];
    
    // Configure the cell...
    if (cell==nil)
    {
        //表格样式采用子标题样式
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell03"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    YHNews *mynews = self.news[indexPath.row];
    cell.textLabel.text = mynews.title;//标题
    cell.detailTextLabel.text = mynews.subtitle;//子标题
    cell.imageView.image = mynews.img;
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    _show = [segue destinationViewController];
    _show.news = _news[_indexPath.row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [self performSegueWithIdentifier:@"searchshow" sender:self];
}

@end
