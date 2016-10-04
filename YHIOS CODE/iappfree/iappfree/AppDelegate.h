//
//  AppDelegate.h
//  iappfree
//
//  Created by 闫合 on 2016/10/3.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 保存所有app信息的数据库
 */
@property (strong, nonatomic) FMDatabase *db;

@end

