//
//  WYAccountTool.h
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYAccount.h"
@interface WYAccountTool : NSObject
+(void)saveAccount:(WYAccount *)account;
+(WYAccount *)account;
@end
