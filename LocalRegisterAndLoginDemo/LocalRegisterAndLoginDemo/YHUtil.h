//
//  YHUtil.h
//  本地登录注册
//
//  Created by 闫合 on 16/7/11.
//  Copyright © 2016年 闫合. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
@interface YHUtil : NSObject
+(void)alert:(NSString *)msg andViewController:(UIViewController *)viewController;
+(NSString *)getMMSSFromSS:(NSString *)totalTime;
+(void)alert:(NSString *)msg;//old alert method
+(NSString *)trim:(NSString *)str;//突出字符串两端的空格
/**
 *  验证字符串是否为空，并弹出提示信息
 */

+(BOOL)checkString:(NSString *)string AndMessage:(NSString *)msg andView:(UITextField *)sender;
/**
 *  判断字符串中间是否包含空格
 */
+(BOOL)isContainSpaceCharacter:(NSString *)str andPopMessage:(NSString *)msg;
/**
 *  判断字符串中间是否只包含数字和字母
 */
+(BOOL)isOnlyContainNumbersAndLetters:(NSString *)str andPopMessage:(NSString *)msg;

@end
