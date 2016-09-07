//
//  YHUtil.m
//  本地登录注册
//
//  Created by 闫合 on 16/7/11.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "YHUtil.h"
@implementation YHUtil
+(void)alert:(NSString *)msg andViewController:(UIViewController *)viewController
{
        
    //创建一个警报
    UIAlertController *av = [UIAlertController alertControllerWithTitle:@"友情提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    //创建警报的行为
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil];
    //添加行为到警报上
    [av addAction:cancelAction];
    //将警报呈现在视图控制器上
    [viewController presentViewController:av animated:YES completion:nil];
}
#pragma mark 将秒转化为 m：s形式
//传入 秒  得到 xx:xx:xx
+(NSString *)getMMSSFromSS:(NSString *)totalTime
{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
     NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}
+(void)alert:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:msg delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
}
//剔除空格的行为
+(NSString *)trim:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
+(BOOL)checkString:(NSString *)string AndMessage:(NSString *)msg andView:(UITextField *)sender
{
    if ([string isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:msg];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1 completion:^{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            sender.text  = @"";
            [UIView commitAnimations];
        }];
        return NO;
    }
    return YES;
}
+(BOOL)isContainSpaceCharacter:(NSString *)str andPopMessage:(NSString *)msg
{
    if ([str rangeOfString:@" "].location!=NSNotFound) {
        [SVProgressHUD showInfoWithStatus:msg];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1.2];
        return YES;
    }
    return NO;
}
+(BOOL)isOnlyContainNumbersAndLetters:(NSString *)str andPopMessage:(NSString *)msg
{
    for (int i=0; i<str.length; i++)
    {
        char c = [str characterAtIndex:i];
        if ((c>='0'&&c<='9')||(c>='A'&&c<='Z')||(c>='a'&&c<='z'))
        {
            
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:msg];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD dismissWithDelay:1.2];
            return NO;
            
        }
    }
    return YES;

}
@end
