//
//  ModifyPasswordViewController.h
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/6.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUtil.h"
#import "YHDatabase.h"
#import "NSString+equalString.h"
@interface ModifyPasswordViewController : UIViewController
- (IBAction)cancelTap:(UIBarButtonItem *)sender;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UITextField *unameText;
/**
 *  旧密码
 */
@property (weak, nonatomic) IBOutlet UITextField *oldPassText;
/**
 *  新密码
 */
@property (weak, nonatomic) IBOutlet UITextField *myNewPassText;
/**
 *  确认新密码
 */
@property (weak, nonatomic) IBOutlet UITextField *confirmNewPassText;
/**
 *  点击提交按钮
 */
- (IBAction)saveTap:(UIButton *)sender;

@end
