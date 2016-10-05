//
//  LimitFreeTableViewController.h
//  iappfree
//
//  Created by 闫合 on 2016/10/4.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTableViewCell.h"
#import "AppDelegate.h"
#import "EGORefreshTableHeaderView.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
@interface LimitFreeTableViewController : UITableViewController<EGORefreshTableHeaderDelegate>
@property (strong, nonatomic) EGORefreshTableHeaderView *refreshHeaderView;
@property (assign, nonatomic) BOOL reloading;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;;
@end
