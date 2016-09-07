//
//  FontSizeColorViewController.h
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontSizeColorViewController : UIViewController
/**
 *  保存按钮点击事件
 */
- (IBAction)save:(UIBarButtonItem *)sender;
/**
 *  字号调节滑块
 */
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;
/**
 *  字号调节事件
 */
- (IBAction)sizeChanged:(UISlider *)sender;
/**
 *  显示字号标签
 */
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;
/**
 *  R滑块
 */
@property (weak, nonatomic) IBOutlet UISlider *rSlider;
/**
 *  G滑块
 */
@property (weak, nonatomic) IBOutlet UISlider *gSlider;
/**
 *  B滑块
 */
@property (weak, nonatomic) IBOutlet UISlider *bSlider;
/**
 *  实时显示颜色变化的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *showColorLabel;
/**
 *  监听RGB值变化的事件
 */
- (IBAction)colorChanged:(UISlider *)sender;

@end
