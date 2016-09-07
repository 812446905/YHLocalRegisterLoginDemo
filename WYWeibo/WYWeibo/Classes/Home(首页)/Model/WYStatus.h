//
//  WYStatus.h
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYUser.h"
@interface WYStatus : NSObject
/**字符串类型的uid */
@property (nonatomic,strong) NSString *idstr;
/*微博信息内容*/
@property (nonatomic,strong) NSString *text;
/**微博作者的用户信息字段*/
@property (nonatomic,strong) WYUser *user;
+(instancetype)statusWithDict:(NSDictionary *)dict;
@end
