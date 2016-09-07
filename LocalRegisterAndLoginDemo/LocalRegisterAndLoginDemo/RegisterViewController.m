//
//  RegisterViewController.m
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/5.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "RegisterViewController.h"
@interface RegisterViewController ()
@end

@implementation RegisterViewController
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
  
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
}
- (IBAction)tapToendEdit:(id)sender {
    [self.view endEditing:YES];
    [self showNavigationBar];

}
-(void)showNavigationBar
{
    [UIView animateWithDuration:0.4 animations:^{
        self.navigationController.navigationBarHidden = NO;
    } completion:nil];
}
- (IBAction)closeKB:(id)sender {
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


- (IBAction)toLoginPage:(UIButton *)sender {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

- (IBAction)registerBtnTap:(UIButton *)sender {
//1.数据有效性验证
    //获取输入的用户名、密码、确认密码
    NSString *uName = self.unameText.text;
    NSString *uPass = self.upassText.text;
    NSString *uConfirmPass = self.confirmPassText.text;
    //剔除两端空格
    uName = [YHUtil trim:uName];
    uPass = [YHUtil trim:uPass];
    uConfirmPass = [YHUtil trim:uConfirmPass];
     //判断是否输入了空串
    if ([YHUtil checkString:uName AndMessage:@"用户名不能为空" andView:self.unameText]==NO)
    {
        
        return;
    }
    //判断字符串中间是否有空格
    if ([YHUtil isContainSpaceCharacter:uName andPopMessage:@"用户名中间不可以包含空格"]==YES) {
        return;
    }
    //判断是不是只有字母或数字
    if ([YHUtil isOnlyContainNumbersAndLetters:uName andPopMessage:@"用户名只能由数字或字母组成"]==NO) {
        return;
    }
    //
    //判断该用户是否已经被被注册过了
    
    //定制sql
    char *sql = "select * from t_user where uName=?";
    //定义陈述变量
    sqlite3_stmt *stmt;
     //如果已经注册，提示更换用户名后再试
    if ([self isExistedWithSql:sql andStmt:stmt andString:uName]==YES) {
        return;
    }

    /*
    int result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);预处理
    if (result!=SQLITE_OK)
    {
        创建一个警报
        [YHUtil alert:@"准备失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);释放陈述
        return;
    }
    if (sqlite3_bind_text(stmt, 1, [uName UTF8String], -1, NULL)!=SQLITE_OK)绑定参数失败
    {
        
        创建一个警报
        [YHUtil alert:@"数据绑定失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);释放陈述
        return;
    }
    if (sqlite3_step(stmt)==SQLITE_ROW) 如果已经存在，提示更换用户名
    {
        创建一个警报
        [YHUtil alert:@"您要注册的用户已经存在，必须更换为别的用户名！" andViewController:self];
        sqlite3_finalize(stmt);释放陈述
        return;
    }
     */
   
    //如果没有才进行下面操作
    if ([YHUtil checkString:uPass AndMessage:@"密码不能为空" andView:self.upassText]==NO)
    {
        return;
        
    }
    //判断字符串中间是否有空格
    if ([YHUtil isContainSpaceCharacter:uPass andPopMessage:@"密码中间不可以包含空格"]==YES) {
        return;
    }
    //判断是不是只有字母或数字
    if ([YHUtil isOnlyContainNumbersAndLetters:uPass andPopMessage:@"密码只能由数字或字母组成"]==NO) {
        return;
    }

    if ([YHUtil checkString:uConfirmPass AndMessage:@"请再次输入密码" andView:self.confirmPassText]==NO)
    {
        return;
    }
    //判断两次输入的密码是否一致
    if ([uConfirmPass isEqualToString:uPass popMessage:@"两次输入的密码不一致"]==NO)//如果不一致
    {
        return;
    }
  //    [YHUtil alert:@"正在注册..."];

     //2.注册信息到数据库
    //增加这个用户
           sql = "insert into t_user values(?,?)";
    /*
     int  result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);
     if (result!=SQLITE_OK)
     {
     创建一个警报
     [YHUtil alert:@"准备失败，请稍后再试！" andViewController:self];
     sqlite3_finalize(stmt);释放陈述
     return;
     }
     绑定参数
     绑定第一个参数
     result = sqlite3_bind_text(stmt, 1, [uName UTF8String], -1, NULL);
     if (result!=SQLITE_OK)绑定参数失败
     {
     创建一个警报
     [YHUtil alert:@"账号绑定失败，请稍后再试！" andViewController:self];
     sqlite3_finalize(stmt);释放陈述
     return;
     }
     绑定第二个参数
     result = sqlite3_bind_text(stmt, 2, [uPass UTF8String], -1, NULL);
     if (result!=SQLITE_OK)绑定参数失败
     {
     创建一个警报
     [YHUtil alert:@"密码绑定失败，请稍后再试！" andViewController:self];
     sqlite3_finalize(stmt);释放陈述
     return;
     }
     if (sqlite3_step(stmt)!=SQLITE_DONE) 注册失败
     {
     创建一个警报
     [YHUtil alert:@"对不起，注册失败，请稍后再试！" andViewController:self];
     sqlite3_finalize(stmt);释放陈述
     return;
     }
     */
    [SVProgressHUD showWithStatus:@"正在注册..."];
    [self.registerBtn setTitle:@"正在注册..." forState:UIControlStateNormal];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD dismissWithDelay:1 completion:^{
        BOOL res = [self isRegisterSucessWithSql:sql andWithStmt:stmt andWithName:uName andWithPassword:uPass];
        if (res==NO)
        {
            return;
        }
        else
        {
            
        [self.registerBtn setTitle:@"注  册" forState:UIControlStateNormal];
            //创建一个警报
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜你，注册成功" message:@"是否前往登录？"preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
                [[NSUserDefaults standardUserDefaults] setObject:uName forKey:@"USERNAME"];
                [[NSUserDefaults standardUserDefaults] setObject:uPass forKey:@"USERPASS"];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }

    }];

}
/**
 *  判断是否注册成功
 */
-(BOOL)isRegisterSucessWithSql:(char *)sql andWithStmt:(sqlite3_stmt *)stmt andWithName:(NSString *)name andWithPassword:(NSString *)pass
{
    int  result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);
    if (result!=SQLITE_OK)
    {
        //创建一个警报
        [YHUtil alert:@"准备失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return NO;
    }
    //绑定参数
    //绑定第一个参数
    result = sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
    if (result!=SQLITE_OK)//绑定参数失败
    {
        //创建一个警报
        [YHUtil alert:@"账号绑定失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return NO;
    }
    //绑定第二个参数
    result = sqlite3_bind_text(stmt, 2, [pass UTF8String], -1, NULL);
    if (result!=SQLITE_OK)//绑定参数失败
    {
        //创建一个警报
        [YHUtil alert:@"密码绑定失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return NO;
    }
   
    if (sqlite3_step(stmt)!=SQLITE_DONE) //注册失败
    {
        //创建一个警报
        [YHUtil alert:@"对不起，注册失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return NO;
    }
    return YES;
}
/**
 *  判断要注册的用户名是否存在
 */
-(BOOL)isExistedWithSql:(char *)sql andStmt:(sqlite3_stmt *)stmt andString:(NSString *)str
{
    int result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);//预处理
    if (result!=SQLITE_OK)
    {
        //创建一个警报
        [YHUtil alert:@"准备失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return YES;
    }
    if (sqlite3_bind_text(stmt, 1, [str UTF8String], -1, NULL)!=SQLITE_OK)//绑定参数失败
    {
        
        //创建一个警报
        [YHUtil alert:@"数据绑定失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return YES;
    }
    if (sqlite3_step(stmt)==SQLITE_ROW) //如果已经存在，提示更换用户名
    {
        //创建一个警报
        [YHUtil alert:@"该用户已注册，必须更换为别的用户名！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return YES;
    }
    return NO;
}
@end
