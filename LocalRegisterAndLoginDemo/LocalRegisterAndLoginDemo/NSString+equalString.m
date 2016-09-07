//
//  NSString+equalString.m
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/6.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "NSString+equalString.h"
#import "SVProgressHUD.h"
@implementation NSString (equalString)
-(BOOL)isEqualToString:(NSString *)aString popMessage:(NSString *)msg
{
    if ([self isEqualToString:aString]==NO) {
        
        [SVProgressHUD showInfoWithStatus:msg];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1.2];

        return NO;
    }
    return YES;
}
@end
