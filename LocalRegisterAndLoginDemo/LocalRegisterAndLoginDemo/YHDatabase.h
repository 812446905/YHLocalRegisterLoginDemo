//
//  YHDatabase.h
//  本地登录注册
//
//  Created by 闫合 on 16/7/11.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <UIKit/UIKit.h>
/**
 *  封装的sqlite数据库操作类
 */
@interface YHDatabase : NSObject
+(BOOL)openDatabase:(NSString *)name withMessage:(NSString *)msg;//打开数据库
+(BOOL)execSql:(NSString *)sql withMessage:(NSString *)msg;//执行sql语句
+(sqlite3 *)db;
@end
