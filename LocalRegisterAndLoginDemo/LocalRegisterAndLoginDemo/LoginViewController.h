//
//  LoginViewController.h
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/5.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUtil.h"
#import "SVProgressHUD.h"
#import "YHDatabase.h"
#import "CustomSwitch.h"
@interface LoginViewController : UIViewController

- (IBAction)toRegisterPager:(UIButton *)sender;
/**
 *  记住密码开关
  */
@property (nonatomic,weak) IBOutlet CustomSwitch *switchOne;
/**
 *  记住密码标签
 */
@property (weak, nonatomic) IBOutlet UILabel *rememberLabel;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UITextField *unameText;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *upassText;
/**
 *  点击登录
 */
- (IBAction)login:(UIButton *)sender;
/**
 *  点击修改用户名
 */
- (IBAction)modifyUserName:(UIButton *)sender;
/**
 *  点击修改密码
 */
- (IBAction)modifyPassword:(UIButton *)sender;
/**
 *  登录按钮
 */
- (IBAction)switchClick:(CustomSwitch *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)deleteUser:(UIButton *)sender;
@end
