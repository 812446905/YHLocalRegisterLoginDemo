//
//  ModifyUserNameViewController.h
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/6.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUtil.h"
#import "YHDatabase.h"
#import "SVProgressHUD.h"
@interface ModifyUserNameViewController : UIViewController
- (IBAction)cancelTap:(UIBarButtonItem *)sender;
- (IBAction)saveTap:(UIButton *)sender;
- (IBAction)endEdit:(id)sender;
- (IBAction)closeKB:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *oldUnameText;
@property (weak, nonatomic) IBOutlet UITextField *upassText;
@property (weak, nonatomic) IBOutlet UITextField *myNewUnameText;

@end
