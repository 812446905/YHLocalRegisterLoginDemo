//
//  ShowFontEffectViewController.h
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUtil.h"
@interface ShowFontEffectViewController : UIViewController
/**
 *  返回首页按钮点击事件
 */
- (IBAction)back:(UIBarButtonItem *)sender;
/**
 *  显示字体效果的文本域
 */
@property (weak, nonatomic) IBOutlet UITextView *resultText;
/**
 *  字号
 */
@property (nonatomic,assign) float fontSize;
/**
 *  字体名称
 */
@property (nonatomic,copy) NSString *fontName;
/**
 *  字体颜色
 */
@property (nonatomic,strong) UIColor *fontColor;
@end
