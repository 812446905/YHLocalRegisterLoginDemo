//
//  LimitFreeTableViewController.h
//  iappfree
//
//  Created by 闫合 on 2016/10/4.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTableViewCell.h"
#import "Reachability.h"
@interface LimitFreeTableViewController : UITableViewController
@property (strong, nonatomic) Reachability *reach;
@property (strong, nonatomic) Reachability *internetReach;
@end
