//
//  ShowViewController.h
//  YHNews
//
//  Created by 闫合 on 16/8/2.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHNews.h"
@interface ShowViewController : UIViewController
@property (nonatomic,strong) YHNews *news;
@property (weak, nonatomic) IBOutlet UITextView *titleText;
@property (weak, nonatomic) IBOutlet UITextView *subtitleText;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@end
