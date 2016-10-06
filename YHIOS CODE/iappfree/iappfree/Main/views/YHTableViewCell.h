//
//  YHTableViewCell.h
//  iappfree
//
//  Created by 闫合 on 2016/10/4.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shareSaveDownloadLabel;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *freeCountDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star1_image;
@property (weak, nonatomic) IBOutlet UIImageView *star2_image;
@property (weak, nonatomic) IBOutlet UIImageView *star3_image;
@property (weak, nonatomic) IBOutlet UIImageView *star4_image;
@property (weak, nonatomic) IBOutlet UIImageView *star5_image;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end
