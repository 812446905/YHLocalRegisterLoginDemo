//
//  WYHomeViewController.m
//  沃赢微博
//
//  Created by 闫合 on 16/8/12.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYHomeViewController.h"
#import "AFNetworking.h"
#import "WYAccountTool.h"
#import "WYStatus.h"
@interface WYHomeViewController ()
@property (nonatomic,strong) NSMutableArray *statuses;
@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statuses = [[NSMutableArray alloc]initWithCapacity:100];
    //设置左边导航项
    UIBarButtonItem *left =  [self setBarButtonItemWithImageName:@"navigationbar_friendsearch" highlightedImageName:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.leftBarButtonItem = left;
    //设置右边导航项
    UIBarButtonItem *right =  [self setBarButtonItemWithImageName:@"navigationbar_pop"highlightedImageName:@"navigationbar_pop_highlighted"];
    self.navigationItem.rightBarButtonItem = right;
    [self getOtherName];
    [self weiboData];
    [self.tableView reloadData];
}
//获取用户名
-(void)getOtherName
{
    /*
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    uid	false	int64	需要查询的用户ID。
     */
    WYAccount *account = [WYAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:account.access_token,@"access_token",account.uid,@"uid", nil];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        //NSLog(@"%@",responseObject);
        self.navigationItem.title = [responseObject objectForKey:@"name"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
/**
 *  获取微博的数据
 */
-(void)weiboData
{
    WYAccount *account = [WYAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:account.access_token,@"access_token",@2,@"count", nil];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"statuses"];
        for (WYStatus * status in arr)
        {
            NSLog(@"status=%@",status);
            [self.statuses addObject:status];
        }
        //WYStatus *status = [WYStatus statusWithDict:responseObject];
        //[self.tableView reloadData];
       // NSLog(@"微博有：%@",status);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - 定制导航栏左右按钮方法
/**
 *  创建导航项
 *
 *  @param imageName            按钮正常状态下的图片
 *  @param highlightedImageName 按钮高亮下的图片
 *
 *  @return 一个导航项
 */
-(UIBarButtonItem *)setBarButtonItemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName
{
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
    item.customView = btn;
    return item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statuses.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"这个方法调用了");
    static NSString *ID = @"STATUS";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    WYStatus *status = self.statuses[indexPath.row];
    WYUser *user = status.user;
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
    [self.tableView reloadData];
    return cell;
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
