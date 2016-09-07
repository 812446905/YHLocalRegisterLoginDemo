//
//  NewsTableViewController.h
//  YHNews
//
//  Created by 闫合 on 16/8/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *guoneiBtn;
@property (weak, nonatomic) IBOutlet UIButton *guojiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shehuiBtn;
@property (weak, nonatomic) IBOutlet UIButton *gongyiBtn;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak,nonatomic) IBOutlet UIButton *newsBtn;
@end
