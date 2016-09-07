//
//  SaveTableViewController.m
//  YHNews
//
//  Created by 闫合 on 16/8/3.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "SaveTableViewController.h"
#import "ShowViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"

@interface SaveTableViewController ()
//保存所有收藏的新闻
@property (nonatomic,strong) NSMutableArray *news;
@property (nonatomic,strong) ShowViewController *show;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

@implementation SaveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _news = [[NSMutableArray alloc]initWithCapacity:100];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadLocalData];
    //增加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(refreshTap)];
    //增加上拉加载，分页功能
    [self.tableView addFooterWithTarget:self action:@selector(loadTap)];

}
-(void)refreshTap
{
    [self loadLocalData];
    [self.tableView headerEndRefreshing];
}
-(void)loadTap
{
    [self.tableView footerEndRefreshing];
}
-(void)loadLocalData
{
    [_news removeAllObjects];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    FMDatabase *db = appDelegate.db;//获取应用程序数据库
    FMResultSet *rs = [db executeQuery:@"select * from saves"];
    while (rs.next)
    {
        YHNews *xinwen = [[YHNews alloc]init];
        xinwen.title = [rs stringForColumn:@"title"];
        xinwen.subtitle = [rs stringForColumn:@"subtitle"];
        xinwen.idid = [NSNumber numberWithInt:[rs intForColumn:@"idid"]] ;
        xinwen.author = [rs stringForColumn:@"author"];
        xinwen.picture = [rs stringForColumn:@"picture"];
        xinwen.flid = [NSNumber numberWithInt:[rs intForColumn:@"flid"]];
        xinwen.content = [rs stringForColumn:@"content"];
        xinwen.clicks = [NSNumber numberWithInt:[rs intForColumn:@"clicks"]];
        xinwen.time = [rs stringForColumn:@"time"];
        xinwen.img = [UIImage imageWithData:[rs dataNoCopyForColumn:@"pic"]];
        [_news addObject:xinwen];
    }
    [self.tableView reloadData];
}

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
    return _news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell04"];
    
    // Configure the cell...
    if (cell==nil)
    {
        //表格样式采用子标题样式
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell04"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    YHNews *mynews = _news[indexPath.row];
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
    [self performSegueWithIdentifier:@"saveshow" sender:self];
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
