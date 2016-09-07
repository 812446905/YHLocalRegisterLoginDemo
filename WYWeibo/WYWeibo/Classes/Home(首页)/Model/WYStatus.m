//
//  WYStatus.m
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYStatus.h"

@implementation WYStatus
+(instancetype)statusWithDict:(NSDictionary *)dict
{
    WYStatus *status = [[self alloc]init];
    status.idstr = [dict objectForKey:@"idstr"];
    status.text = [dict objectForKey:@"tetx"];
    status.user = [dict objectForKey:@"user"];
    return status;
}
@end
