//
//  ModifyUserNameViewController.m
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/6.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "ModifyUserNameViewController.h"
@interface ModifyUserNameViewController ()

@end
@implementation ModifyUserNameViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)cancelTap:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveTap:(UIButton *)sender {
   
    //1.数据有效性验证
    //获取输入的用户名、密码、新用户名
    NSString *uName = self.oldUnameText.text;
    NSString *uPass = self.upassText.text;
    NSString *newUName = self.myNewUnameText.text;
    //剔除两端空格
    uName = [YHUtil trim:uName];
    uPass = [YHUtil trim:uPass];
    newUName = [YHUtil trim:newUName];
    //判断是否输入了空串
    if ([YHUtil checkString:uName AndMessage:@"旧用户名不能为空" andView:self.oldUnameText]==NO)
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
    if ([YHUtil checkString:uPass AndMessage:@"密码不能为空" andView:self.upassText]==NO)
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
    if (![uPass isEqualToString:password])//
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
    if ([YHUtil checkString:newUName AndMessage:@"用户名不能为空" andView:self.myNewUnameText]==NO)
    {
        
        return;
    }
    //判断字符串中间是否有空格
    if ([YHUtil isContainSpaceCharacter:newUName andPopMessage:@"用户名中间不可以包含空格"]==YES) {
        return;
    }
    //判断是不是只有字母或数字
    if ([YHUtil isOnlyContainNumbersAndLetters:newUName andPopMessage:@"用户名只能由数字或字母组成"]==NO) {
        return;
    }
    //
    //判断该用户是否已经被被注册过了
    
    //定制sql
    sql = "select * from t_user where uName=?";
    //如果已经注册，提示更换用户名后再试
    res = [self isExistedWithSql:sql stmt:stmt parameter:newUName errorInfo:@"该用户已被注册，必须更换为别的用户名！"returnFlag:YES];
    if (res==YES) {
        
        return;
    }
    
    
    //如果没有才进行下面操作
    sql = "update t_user set uName=? where uName=?";
    result = sqlite3_prepare_v2([YHDatabase db], sql, -1, &stmt, NULL);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:[NSString stringWithFormat:@"确定将用户名修改为%@？",newUName]preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        BOOL bFlag = NO;
        if (result==SQLITE_OK)
        {
            //绑定第一个参数
            result = sqlite3_bind_text(stmt, 1, [newUName UTF8String], -1, NULL);
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
                    
                    [SVProgressHUD showSuccessWithStatus:@"用户名修改成功！"];
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                    [SVProgressHUD dismissWithDelay:1.2 completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                        [[NSUserDefaults standardUserDefaults] setObject:newUName forKey:@"USERNAME"];
                        [[NSUserDefaults standardUserDefaults] setObject:uPass forKey:@"USERPASS"];
                    }];
                }
            }
        }

        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    //

   
    
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

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
