//
//  LoginViewController.m
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/5.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()<CustomSwitchDelegate>

@end

@implementation LoginViewController

#pragma mark - customSwitch delegate
-(void)customSwitchSetStatus:(CustomSwitchStatus)status
{
    switch (status) {
        case CustomSwitchStatusOn:
            //todo
            break;
        case CustomSwitchStatusOff:
            //todo
            break;
        default:
            break;
    }
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self enterLoginOrRegister];
    _switchOne.arrange = CustomSwitchArrangeONLeftOFFRight;
    _switchOne.onImage = [UIImage imageNamed:@"switchOne_on"];
    _switchOne.offImage = [UIImage imageNamed:@"switchOne_off.png"];
    _switchOne.status = CustomSwitchStatusOff;
    
//    NSString *uName = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
//    NSString *uPass = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERPASS"];
//    NSLog(@"%@,%@",uName,uPass);
//    if (uName.length>0 && uPass.length>0)
//    {
//        _switchOne.status=CustomSwitchStatusOn;
//        self.unameText.text = uName;
//        self.upassText.text = uPass;
//    }

}
//判断是否是全新安装，如果是，进入注册页面
-(void)enterLoginOrRegister
{
    //判断应用程序是否全新安装，以决定进入登录界面还是注册界面
    //获取保存旧版本的文件
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"version.plist"];
    //获取旧版本
    NSMutableDictionary *oldVersionDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //获取当前版本
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = [dict valueForKeyPath:@"CFBundleVersion"];
    
    if (!oldVersionDict)//全新安装 转到注册界面
    {
        [self performSegueWithIdentifier:@"registerSegue" sender:self];
        //把版本保存下来
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:currentVersion forKeyPath:@"CFBundleVersion"];
        [dict writeToFile:path atomically:YES];
    }
    //旧版本文件存在，不是全新安装
    //保存当前的版本到磁盘
    [oldVersionDict setValue:currentVersion forKeyPath:@"CFBundleVersion"];

//    [oldVersionDict setValue:currentVersion forKey:@"CFBundleVersion"];
    [oldVersionDict writeToFile:path atomically:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *uName = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
    NSString *uPass = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERPASS"];
    NSLog(@"%@,%@",uName,uPass);
    if (uName.length>0 && uPass.length>0)
    {
        _switchOne.status=CustomSwitchStatusOn;
        self.unameText.text = uName;
        self.upassText.text = uPass;
    }

      self.navigationItem.hidesBackButton = YES;
}
- (IBAction)tapToEndEdit:(id)sender {
    [self.view endEditing:YES];
    [self showNavigationBar];
    
}
-(void)showNavigationBar
{
    [UIView animateWithDuration:0.4 animations:^{
        self.navigationController.navigationBarHidden = NO;
    } completion:nil];
}
- (IBAction)closeKB {
    [self showNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
}


- (IBAction)toRegisterPager:(UIButton *)sender {
    [self performSegueWithIdentifier:@"registerSegue" sender:self];
}
#pragma mark - 点击登录按钮
- (IBAction)login:(UIButton *)sender {
    [self showNavigationBar];
    //0.获取输入的用户名和密码
    NSString *uName = self.unameText.text;
    NSString *uPass = self.upassText.text;
    
    //剔除字符串两端的空格
    uName = [YHUtil trim:uName];
    uPass = [YHUtil trim:uPass];
    //1.对获得的数据进行有效性验证
       //1.1未通过验证，提示错误信息弹窗，并return
    if ([YHUtil checkString:uName AndMessage:@"用户名不能为空" andView:self.unameText]==NO)
    {
        return;
    }
    if ([YHUtil checkString:uPass AndMessage:@"密码不能为空" andView:self.upassText]==NO)
    {
        return;

    }
       //1.2通过验证，关闭键盘，修改登录按钮上的文字为”正在登录...“,并弹出界面提示正在登录
    [self closeKB];
    //弹出登录提示框
    [self promptMessage:@"正在登录..." andSetTitle:@"正在登录..." forSender:self.loginBtn WithUname:uName andWithUpass:uPass];
       
}
#pragma mark - 数据库查询用户信息
-(BOOL)isExistUserInfoWithSql:(char *)sql andWithStmt:(sqlite3_stmt *)stmt andWithName:(NSString *)uName andWithPassword:(NSString *)uPass
{

    int result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);//预处理
    if (result!=SQLITE_OK)
    {
        //创建一个警报
        [YHUtil alert:@"对数据库操作失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return NO;
    }
    if (sqlite3_bind_text(stmt, 1, [uName UTF8String], -1, NULL)!=SQLITE_OK)//绑定第一个参数失败
    {
        //创建一个警报
        [YHUtil alert:@"对数据库操作失败，请稍后再试！！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return NO;
    }
    //绑定第二个参数失败
    if (sqlite3_bind_text(stmt, 2, [uPass UTF8String], -1, NULL)!=SQLITE_OK)
    {
        //创建一个警报
        [YHUtil alert:@"对数据库操作失败，请稍后再试！！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return NO;
    }
    
    if (sqlite3_step(stmt)==SQLITE_ROW)//如果有这个用户的信息
    {
       
        //创建一个警报
        [SVProgressHUD showSuccessWithStatus:@"恭喜你，登录成功"];
        [SVProgressHUD dismissWithDelay:1 completion:^{
            [self performSegueWithIdentifier:@"toMainPage" sender:self];
            [self.loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
        }];

            if (_switchOne.status==CustomSwitchStatusOn)
                {
                    //保存用户名密码到本地
                    [[NSUserDefaults standardUserDefaults] setObject:uName forKey:@"USERNAME"];
                    [[NSUserDefaults standardUserDefaults] setObject:uPass forKey:@"USERPASS"];
                }
                else
                {
                    //从本地移除保存的用户名和密码
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"USERNAME"];
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"USERPASS"];
                }
        return YES;
    }
    else{
        return NO;
    }
    return YES;
}
/**
 *  弹出提示信息
 */
-(void)promptMessage:(NSString *)msg andSetTitle:(NSString *)title forSender:(UIButton *)button WithUname:(NSString *)uName andWithUpass:(NSString *)uPass
{
    //修改按钮上的文字
    [button setTitle:title forState:UIControlStateNormal];
    [SVProgressHUD showWithStatus:msg];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultMaskType: SVProgressHUDMaskTypeClear];
    [SVProgressHUD dismissWithDelay:0.8 completion:^{
        //2.在数据库里查找，看是否存在输入的用户信息
        //定制sql
        
        //定义陈述变量
        sqlite3_stmt *stmt;
        char *sql = "select * from t_user where uName=? and uPass=?";
        BOOL res = [self isExistUserInfoWithSql:sql andWithStmt:stmt andWithName:uName andWithPassword:uPass];
        if (res==YES)
        {
            //2.1如何有，提示“你已成功登录”
            
            //2.2进入另一个界面
            
        }
        else
        {
            //2.3如果没有，提示”登录失败，您输入的用户名或密码错误“
            [SVProgressHUD showErrorWithStatus:@"登录失败，您输入的用户名或密码错误"];
            [self.loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
            [SVProgressHUD dismissWithDelay:1 completion:^{
                            }];
        }

    }];
}
#pragma mark - 点击修改用户名
- (IBAction)modifyUserName:(UIButton *)sender {
    //转到修改用户名界面
    [self performSegueWithIdentifier:@"toModifyUserName" sender:self];
}
#pragma mark - 点击修改密码
- (IBAction)modifyPassword:(UIButton *)sender {
    //转到修改密码界面
    [self performSegueWithIdentifier:@"toModifyPassword" sender:self];
}
/**
 *  点击记住密码开关
 */
- (IBAction)switchClick:(CustomSwitch *)sender {
    if (_switchOne.status==CustomSwitchStatusOff)//未记住
    {
                _switchOne.status=CustomSwitchStatusOn;//标示改为记住
    }else
    {
        
      _switchOne.status=CustomSwitchStatusOff;//标示改为不记住
    }

}
#pragma mark - 点击删除用户
- (IBAction)deleteUser:(UIButton *)sender {
    //转到删除用户界面
    [self performSegueWithIdentifier:@"toDeleteUser" sender:self];
}
@end
