//
//  FontSettingViewController.m
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "FontSettingViewController.h"
@interface FontSettingViewController ()
/**
 *  保存按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation FontSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏导航栏返回按钮
    self.navigationItem.hidesBackButton = YES;
    //设置按钮倒角
    self.saveBtn.layer.cornerRadius = 0.25*self.saveBtn.frame.size.height;
    self.saveBtn.layer.borderWidth = 0.5;
    self.text.text = [YHUtil passString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//}


- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (IBAction)save:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"toFontType" sender:self];
    [YHUtil setPassString:self.text.text];
    NSLog(@"pass=%@",[YHUtil passString]);
}

- (IBAction)closeKB:(id)sender {
}
@end
