//
//  YHDatabase.m
//  本地登录注册
//
//  Created by 闫合 on 16/7/11.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "YHDatabase.h"
#import "YHUtil.h"
#import "SVProgressHUD.h"

static sqlite3 *db = NULL;
@implementation YHDatabase
//打开数据库
+(BOOL)openDatabase:(NSString *)name withMessage:(NSString *)msg
{
    //创建打开数据库的路径和文件名
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    filePath = [filePath stringByAppendingPathComponent:name];
    NSLog(@"%@",filePath);
    int result = sqlite3_open([filePath UTF8String], &db);
    if (result!=SQLITE_OK)
    {
        //创建一个警报
        [SVProgressHUD showInfoWithStatus:msg];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1];
        
        return NO;
    }

    return YES;
}
+(BOOL)execSql:(NSString *)sql withMessage:(NSString *)msg
{
    //在这个数据库中创建用户信息表
    char *error;
    int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error);
    if (result!=SQLITE_OK)
    {
        //创建一个警报
        [SVProgressHUD showInfoWithStatus:msg];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1];

        sqlite3_close(db);
        return NO;
    }
    return YES;
}
+(sqlite3 *)db
{
    return db;
}
@end
