//
//  LimitFreeTableViewController.m
//  iappfree
//
//  Created by 闫合 on 2016/10/4.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "LimitFreeTableViewController.h"

@interface LimitFreeTableViewController ()
{
    //应用列表
    NSMutableArray *appList;
    NSMutableArray *tempArr;
    NSInteger page;//上拉到哪一页了，，初始值为1，每一次上拉，page+1
}
@end

@implementation LimitFreeTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//
//    self.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     tempArr = [NSMutableArray arrayWithCapacity:10];
    appList = [[NSMutableArray alloc]initWithCapacity:1000];
   
    //检查网络设置
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NetworkStatus netStatus = [appDelegate.reach currentReachabilityStatus];
//    NSLog(@"%ld",(long)netStatus);
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self SVProgressHUDShowSetting];
    //判断网络状态
    if (netStatus==NotReachable)
    {
        NSLog(@"客官，咋整的，没有联网，数据将从本地加载！");
        //从本地加载数据
        [self loadLocalData];
        
    }
    else
    {
        page = 1;
        NSLog(@"哎呀，妈呀，网络杠杠的，将为你从远端获取数据！");
        //有网络，从远端加载数据
        [self loadRemoteData];
        [self reloadTableViewDataSource];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.0];

        NSLog(@"%ld",appList.count);
        [self.tableView reloadData];
        
    }
   [SVProgressHUD dismissWithDelay:1];
    //创建下拉刷新控件
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
        
    }
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
   
    //增加上拉加载控件
    [self.tableView addFooterWithTarget:self action:@selector(loadTap)];
  ;
}
-(void)viewWillAppear:(BOOL)animated
{
   
}
#pragma mark - 加载数据
/**
 加载本地数据
 */
-(void)loadLocalData
{
    [appList removeAllObjects];

}
/**
 加载远端数据
 */
-(void)loadRemoteData
{
    //从接口获取数据，接口是哪一个呢？
    NSString *strUrl = [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=%ld",(long)page];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        [self performSelectorOnMainThread:@selector(parseJsonData:) withObject:data waitUntilDone:NO];
         }];
    [task resume];
}
-(void)parseJsonData:(NSData *)data
{
    if (data) {
        NSDictionary *applicationsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *applicationsArray = [applicationsDict valueForKeyPath:@"applications"];
        if (applicationsArray.count>0)
        {
            
            for (NSDictionary *dict in applicationsArray)
            {
                YHApps *appModel = [YHApps appModelWithDict:dict];
                appModel.icon = [appModel getIconWithUrlString:appModel.iconUrl];
                [tempArr addObject:appModel];
            }
            [appList addObjectsFromArray:tempArr];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@"filedd"] status:@"数据加载失败，请稍后再试吧！"];
            [SVProgressHUD dismissWithDelay:2 completion:^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否刷新重试？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"刷新一下" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"刷新了");
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"稍后再试吧！" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }];
        }
    }
}
-(void)loadTap
{
    [self reloadTableViewDataSource];
    [self.tableView reloadData];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.0];

    [self.tableView footerEndRefreshing];
      
}
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    NSLog(@"这个reloadTableView方法被调用了!");
    [SVProgressHUD showWithStatus:@"加载中..."];
    //检查网络设置
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NetworkStatus netStatus = [appDelegate.reach currentReachabilityStatus];
    if (netStatus==NotReachable) {
        [SVProgressHUD showInfoWithStatus:@"网络连接断开，这就很尴尬了！"];
        [self loadLocalData];
        [self.tableView reloadData];
    }
    else
    {
         page++;
        [self loadRemoteData];
        [appList addObjectsFromArray:tempArr];
         NSLog(@"加载到第%ld页了",page);
        NSLog(@"%ld",tempArr.count);
        NSLog(@"%ld",appList.count);
        [self.tableView reloadData];
    }

    [self SVProgressHUDShowSetting];
    [self loadRemoteData];
    [self performSelectorInBackground:@selector(loadMore:) withObject:tempArr];
    _reloading = YES;
    
}
-(void)SVProgressHUDShowSetting
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}
- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    
    [SVProgressHUD dismiss];
    NSLog(@"这个doneloading方法被调用了!");
    _reloading = NO;
//    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
-(void)loadMore:(NSMutableArray *)more
{
    
//    NSMutableArray *more
    
    //加载你的数据
    
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
    
}
-(void)appendTableWith:(NSMutableArray *)data
{
//    for (int i=0;i<[data count];i++) {
//        
//        [appList addObject:[data objectAtIndex:i]];
//    }
    [appList addObjectsFromArray:data];
    
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
    
    for (int ind = 0; ind < tempArr.count; ind++) {
        
        NSIndexPath *newPath =  [NSIndexPath indexPathForRow:[appList indexOfObject:[data objectAtIndex:ind]] inSection:0];
        
        [insertIndexPaths addObject:newPath];
        
    }
    
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
//     [self loadRemoteData];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.0];
     [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
//    [self loadRemoteData];
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

- (void)viewDidUnload {
    _refreshHeaderView=nil;
}

- (void)dealloc {
    
    _refreshHeaderView = nil;
}

- (IBAction)endSearch:(id)sender {
    [self.tableView endEditing:YES];
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
    return appList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"limitFreeCell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[YHTableViewCell alloc]init];
    }
    YHApps *myApp = appList[indexPath.row];
    cell.appNameLabel.text = [NSString stringWithFormat:@"%ld.%@",indexPath.row+1,myApp.appName];
    cell.appIcon.image = myApp.icon;
//    NSLog(@"%@",myApp.icon);
//    cell.appNameLabel.text = [NSString stringWithFormat:@"%ld.第%ld个应用",indexPath.row+1,indexPath.row+1];
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
