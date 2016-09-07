//
//  WYAccountTool.m
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYAccountTool.h"

@implementation WYAccountTool
/**
 *  把account保存到沙盒文件中去
 *
 *  @param account
 */
+(void)saveAccount:(WYAccount *)account
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"account.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}
/**
 *  从文件中读取数据，并还原成account对象
 *
 *  @return
 */
+(WYAccount *)account
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"account.data"];
    
    WYAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return account;
}
@end
