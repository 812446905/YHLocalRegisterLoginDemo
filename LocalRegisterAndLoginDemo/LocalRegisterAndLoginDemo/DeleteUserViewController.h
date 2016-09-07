//
//  DeleteUserViewController.h
//  LocalRegisterAndLoginDemo
//
//  Created by 闫合 on 16/9/6.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUtil.h"
#import "YHDatabase.h"
@interface DeleteUserViewController : UIViewController
- (IBAction)closeKB:(id)sender;
- (IBAction)cancelTap:(UIBarButtonItem *)sender;
- (IBAction)deleteTap:(UIBarButtonItem *)sender;
- (IBAction)endEdit:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UITextField *unameText;
@property (weak, nonatomic) IBOutlet UITextField *upassText;

@end
