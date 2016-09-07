//
//  YHUtil.h
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  我的实用类
 */
@interface YHUtil : NSObject
/**
    定制各个静态变量的set和get方法
 */
+(void)setPassString:(NSString *)string;
+(NSString *)passString;
+(void)setFontSize:(float)size;
+(float)fontSize;
+(void)setFontName:(NSString *)name;
+(NSString *)fontName;
+(void)setFontColor:(UIColor *)color;
+(UIColor *)fontColor;
@end
