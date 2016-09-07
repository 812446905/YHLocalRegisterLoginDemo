//
//  WYAccount.h
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  {
 "access_token" = "2.00YgRQNGHuzliB1bce6b4b2bIyDbBB";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5692770594;
 }
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	string	当前授权用户的UID。
 */

@interface WYAccount : NSObject<NSCoding>
//用于调用access_token，接口获取授权后的access token。
@property (nonatomic,strong) NSString *access_token;
//access_token的生命周期，单位是秒数。
@property (nonatomic,strong) NSString  *expires_in;
//当前授权用户的UID。
@property (nonatomic,strong) NSString *uid;
+(instancetype)accountWithDict:(NSDictionary *)dict;//提供一个类方法
-(instancetype)initWithDict:(NSDictionary *)dict;//提供一个对象方法
@end
