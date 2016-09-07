//
//  NSString+equalString.h
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/6.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (equalString)
/**
 *  判断一个字符是否和另一个字符串相同，并弹出提示
 */
-(BOOL)isEqualToString:(NSString *)aString popMessage:(NSString *)msg;
@end
