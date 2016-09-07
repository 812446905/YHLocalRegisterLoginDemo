//
//  ModifyPasswordViewController.m
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/6.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)endEdit:(id)sender {
    [self.view endEditing:YES];
    [self showNavigationBar];
}

- (IBAction)closeKB:(UITextField *)sender {
    [self showNavigationBar];
}

-(void)showNavigationBar
{
    [UIView animateWithDuration:0.4 animations:^{
        self.navigationController.navigationBarHidden = NO;
    } completion:nil];
}

- (IBAction)cancelTap:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveTap:(UIButton *)sender {
    //1.数据有效性验证
    //获取输入的用户名、旧密码、新密码、确认新密码
    NSString *uName = self.unameText.text;
    NSString *oldPass = self.oldPassText.text;
    NSString *myNewPass = self.myNewPassText.text;
    NSString *confirmNewPass = self.confirmNewPassText.text;
    //剔除两端空格
    uName = [YHUtil trim:uName];
    oldPass = [YHUtil trim:oldPass];
    myNewPass = [YHUtil trim:myNewPass];
    confirmNewPass = [YHUtil trim:confirmNewPass];
    //判断是否输入了空串
    if ([YHUtil checkString:uName AndMessage:@"旧用户名不能为空" andView:self.unameText]==NO)
    {
        
        return;
    }
    //判断该用户名是否在数据库中存在
    //定制sql
    char *sql = "select * from t_user where uName=?";
    //定义陈述变量
    sqlite3_stmt *stmt;
    //如果不存在，提示错误信息
    BOOL res = [self isExistedWithSql:sql stmt:stmt parameter:uName errorInfo:@"你输入的用户名不存在，请更换别的试试" returnFlag:NO];
    if (res==NO) {
        return;
    }
    
    //如果存在才进行下面操作
    if ([YHUtil checkString:oldPass AndMessage:@"密码不能为空" andView:self.oldPassText]==NO)
    {
        return;
    }
    //根据用户名查询密码，比较输入的密码和查询密码是否一致
    NSString *password;//查询到的密码
    sql = "select upass from t_user where uName=?";
    
    __block int result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);
    if (result!=SQLITE_OK)
    {
        //创建一个警报
        [YHUtil alert:@"准备失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return;
    }
    if (sqlite3_bind_text(stmt, 1, [uName UTF8String], -1, NULL)!=SQLITE_OK)//绑定参数失败
    {
        
        //创建一个警报
        [YHUtil alert:@"数据绑定失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return;
    }
    //遍历返回的结果
    while (sqlite3_step(stmt)==SQLITE_ROW)//得到返回结果的一行
    {
        //得到这行的第一列
        char *pass = (char *)sqlite3_column_text(stmt, 0);
        //转换成OC的字符串
        password  = [NSString stringWithUTF8String:pass];
        //            NSLog(@"%@",password);
    }
    sqlite3_finalize(stmt);//释放陈述
    if (![oldPass isEqualToString:password])//
    {
        [SVProgressHUD showInfoWithStatus:@"密码不正确，请重新输入"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1.2];
        return;
    }
    //密码正确
    //判断是否输入了空串
    if ([YHUtil checkString:myNewPass AndMessage:@"新密码不能为空" andView:self.myNewPassText]==NO)
    {
        return;
    }
    //判断字符串中间是否有空格
    if ([YHUtil isContainSpaceCharacter:myNewPass andPopMessage:@"密码中间不可以包含空格"]==YES) {
        return;
    }
    //判断是不是只有字母或数字
    if ([YHUtil isOnlyContainNumbersAndLetters:myNewPass andPopMessage:@"密码只能由数字或字母组成"]==NO) {
        return;
    }

    //检验确认密码是否为空
    if ([YHUtil checkString:confirmNewPass AndMessage:@"请再次输入密码" andView:self.confirmNewPassText]==NO)
    {
        return;
    }
     //检验确认密码和新密码是否一致
    if ([confirmNewPass isEqualToString:myNewPass popMessage:@"两次输入的密码不一致"]==NO)//如果不一致
    {
        return;
    }


    
    
    //如果一致才进行下面操作
    sql = "update t_user set uPass=? where uName=?";
    result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:[NSString stringWithFormat:@"确定修改密码？"]preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        BOOL bFlag = NO;
        if (result==SQLITE_OK)
        {
            //绑定第一个参数
            result = sqlite3_bind_text(stmt, 1, [myNewPass UTF8String], -1, NULL);
            if (result!=SQLITE_OK)
            {
                NSLog(@"绑定出错");
                bFlag = YES;
            }
            //绑定第二个参数
            result = sqlite3_bind_text(stmt, 2, [uName UTF8String], -1, NULL);
            if (result!=SQLITE_OK)
            {
                NSLog(@"绑定出错");
                bFlag = YES;
            }
            
            if (bFlag==NO)
            {
                if (sqlite3_step(stmt)!=SQLITE_DONE)
                {
                    NSLog(@"修改失败");
                }
                else
                {
                    
                    [SVProgressHUD showSuccessWithStatus:@"密码修改成功！"];
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                    [SVProgressHUD dismissWithDelay:1.2 completion:^{
                        [self.navigationController popViewControllerAnimated:YES];
                        [[NSUserDefaults standardUserDefaults] setObject:uName forKey:@"USERNAME"];
                        [[NSUserDefaults standardUserDefaults] setObject:myNewPass forKey:@"USERPASS"];
                    }];
                }
            }
        }
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];

    

}
/**
 *  判断查询的数据是否存在
 *
 *  @param sql
 *  @param stmt 陈述
 *  @param str  查询参数
 *  @param error  错误提示信息
 *  @param flag 返回yes or no
 *
 *  @return BOOL
 */
-(BOOL)isExistedWithSql:(char *)sql stmt:(sqlite3_stmt *)stmt parameter:(NSString *)str errorInfo:(NSString *)error returnFlag:(BOOL)flag
{
    
    
    int result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);//预处理
    if (result!=SQLITE_OK)
    {
        //创建一个警报
        [YHUtil alert:@"准备失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return flag;
    }
    if (sqlite3_bind_text(stmt, 1, [str UTF8String], -1, NULL)!=SQLITE_OK)//绑定参数失败
    {
        
        //创建一个警报
        [YHUtil alert:@"数据绑定失败，请稍后再试！" andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return flag;
    }
    if ((sqlite3_step(stmt)==SQLITE_ROW)==flag) //如果已经存在，被注册了
    {
        //创建一个警报
        [YHUtil alert:error andViewController:self];
        sqlite3_finalize(stmt);//释放陈述
        return flag;
    }
    return !flag;
    
    
}

@end
