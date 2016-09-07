//
//  WYUser.h
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYUser : NSObject
/**字符串类型的uid */
@property (nonatomic,strong) NSString *idstr;
/**用户昵称 */
@property (nonatomic,strong) NSString *screen_name;
/**友好显示名称*/
@property (nonatomic,strong) NSString *name;
+(instancetype)userWithDict:(NSDictionary *)dict;
@end
