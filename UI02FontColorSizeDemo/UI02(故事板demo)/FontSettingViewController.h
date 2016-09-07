//
//  FontSettingViewController.h
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUtil.h"
@interface FontSettingViewController : UIViewController
/**
 * 文本框输出口
 */
@property (weak, nonatomic) IBOutlet UITextField *text;
/**
 *  手势点击事件
 */
- (IBAction)tap:(UITapGestureRecognizer *)sender;
/**
 *  保存按钮点击事件
 */
- (IBAction)save:(UIButton *)sender;
/**
 *  文本框退出编辑，关闭键盘
 */
- (IBAction)closeKB:(id)sender;
@end
