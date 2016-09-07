//
//  WYAccount.m
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYAccount.h"

@implementation WYAccount
+(instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.expires_in = [dict objectForKey:@"expires_in"];
        self.access_token = [dict objectForKey:@"access_token"];
        self.uid = [dict objectForKey:@"uid"];
    }
    return self;
}
#pragma mark - NSCoding方法
/**
 *  把对象保存到沙盒时调用
 *
 *  @param encoder
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
}
/**
 *  从沙盒中读取数据还原成对象时调用
 *
 *  @param decoder
 *
 *  @return
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
   
    if (self=[super init])
    {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
    }
    return self;
}
@end
