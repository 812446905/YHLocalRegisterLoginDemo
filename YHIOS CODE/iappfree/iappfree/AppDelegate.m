//
//  AppDelegate.m
//  iappfree
//
//  Created by 闫合 on 2016/10/3.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.reach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [self updateInterfaceWithReachability:self.reach];
    self.status = [self.reach currentReachabilityStatus];
    self.internetReach = [Reachability reachabilityForInternetConnection];
    [self updateInterfaceWithReachability:self.internetReach];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    path = [path stringByAppendingPathComponent:@"YHApps.db"];
    NSLog(@"%@",path);
    //创建数据库
    _db = [FMDatabase databaseWithPath:path];
    //打开数据库
   BOOL b = [_db open];
    if (!b) {
        //创建一个警报
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情 提示" message:@"打开数据库失败，应用将终止！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    //创建表
    b = [_db executeUpdate:@"create table if not exists apps(appId integer,appName text,appDescription text,appCategory text,icon blob,originalPrice integer,limitedFree text,starLevel integer,expireDate text,downloadCount integer,shareCount integer,favoriteCount integer,fileSize integer)"];
    if (!b) {
        //创建一个警报
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"创建数据表失败，应用将终止！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}

-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *curReach = [note object];
    [self updateInterfaceWithReachability:curReach];
    NSLog(@)
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    self.status = [reachability currentReachabilityStatus];
    NSString* statusString = @"";
    
    switch (self.status)
    {
        case NotReachable:        {
            statusString = @"无法连接到网络，请检查网络设置！";
            //创建一个警报
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message: statusString delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
            
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = @"您当前正在使用蜂窝数据！";
            //创建一个警报
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message: statusString delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        case ReachableViaWiFi:        {
            statusString= @"已连接到WiFi网络！";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message: statusString delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
