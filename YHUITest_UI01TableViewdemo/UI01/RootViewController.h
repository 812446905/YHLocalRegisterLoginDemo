//
//  RootViewController.h
//  UI01
//
//  Created by 闫合 on 16/8/29.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneTableViewController.h"
#import "TwoTableViewController.h"
#import "ThreeTableViewController.h"
@interface RootViewController : UIViewController<UIScrollViewDelegate>
/**
 *  滚动视图
 */
@property (nonatomic,strong) UIScrollView *scrollView;
/**
 *  第一个表视图控制器
 */
@property (nonatomic,strong) OneTableViewController *oneVC;
/**
 *  第二个表视图控制器
 */
@property (nonatomic,strong) TwoTableViewController *twoVC;
/**
 *  第三个表视图控制器
 */
@property (nonatomic,strong) ThreeTableViewController *threeVC;
@end
