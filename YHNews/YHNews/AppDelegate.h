//
//  AppDelegate.h
//  YHNews
//
//  Created by 闫合 on 16/7/30.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) FMDatabase *db;

@end

