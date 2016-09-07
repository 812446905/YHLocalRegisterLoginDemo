//
//  RegisterViewController.h
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/5.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUtil.h"
#import "YHDatabase.h"
#import "NSString+equalString.h"
@interface RegisterViewController : UIViewController
- (IBAction)toLoginPage:(UIButton *)sender;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UITextField *unameText;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *upassText;
/**
 *  确认密码
 */
@property (weak, nonatomic) IBOutlet UITextField *confirmPassText;
/**
 *  注册按钮点击
 */
- (IBAction)registerBtnTap:(UIButton *)sender;
/**
 *  注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end
