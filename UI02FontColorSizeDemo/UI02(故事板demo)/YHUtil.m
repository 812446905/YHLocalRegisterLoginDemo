//
//  YHUtil.m
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "YHUtil.h"
/**
 *  传递的字符串
 */
static NSString *passStr = nil;
/**
 *  字体大小
 */
static float fontSize;
/**
 *  字体名称
 */
static NSString *fontName = nil;
/**
 *  字体颜色
 */
static UIColor *fontColor = nil;
@implementation YHUtil
+(void)setPassString:(NSString *)string
{
    passStr = string;
}
+(NSString *)passString
{
    return passStr;
}
+(void)setFontSize:(float)size
{
    fontSize = size;
}
+(float)fontSize
{
    return fontSize;
}
+(void)setFontName:(NSString *)name
{
    fontName = name;
}
+(NSString *)fontName
{
    return fontName;
}
+(void)setFontColor:(UIColor *)color
{
    fontColor = color;
}
+(UIColor *)fontColor
{
    return fontColor;
}
@end
