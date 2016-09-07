//
//  WYUser.m
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYUser.h"

@implementation WYUser
+(instancetype)userWithDict:(NSDictionary *)dict
{
    WYUser *user = [[self alloc]init];
    user.idstr = [dict objectForKey:@"idstr"];
    user.screen_name = [dict objectForKey:@"screen_name"];
    user.name = [dict objectForKey:@"name"];
    return user;
}
@end
