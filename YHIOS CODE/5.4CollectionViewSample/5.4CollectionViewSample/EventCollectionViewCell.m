//
//  EventCollectionViewCell.m
//  5.4CollectionViewSample
//
//  Created by 闫合 on 2016/9/30.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "EventCollectionViewCell.h"

@implementation EventCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat cellW = self.frame.size.width;
        CGFloat imageViewW = 101;
        CGFloat imageViewH = 101;
        CGFloat imageViewTopView = 15;
        //添加imageView
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((cellW-imageViewW)*0.5, imageViewTopView, imageViewW, imageViewH)];
        [self addSubview:self.imageView];
        //添加标签
        CGFloat labelW = 101;
        CGFloat labelH = 16;
        CGFloat labelTopView = 120;
        self.label = [[UILabel alloc]initWithFrame:CGRectMake((cellW-labelW)*0.5, labelTopView, labelW, labelH)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.label];
    }
    return self;
}
@end
