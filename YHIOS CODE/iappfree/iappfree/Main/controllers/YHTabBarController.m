//
//  YHTabBarController.m
//  iappfree
//
//  Created by 闫合 on 2016/10/3.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "YHTabBarController.h"

@interface YHTabBarController ()

@end

@implementation YHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    for (UIBarItem *item in self.tabBar.items)
    {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:13.0], NSFontAttributeName, nil]forState:UIControlStateNormal];
    }

    
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

@end
