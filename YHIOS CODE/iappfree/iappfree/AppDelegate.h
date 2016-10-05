//
//  AppDelegate.h
//  iappfree
//
//  Created by 闫合 on 2016/10/3.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *reach;
@property (strong, nonatomic) Reachability *internetReach;
@property (assign, nonatomic) NetworkStatus status;
/**
 保存所有app信息的数据库
 */
@property (strong, nonatomic) FMDatabase *db;
@end

