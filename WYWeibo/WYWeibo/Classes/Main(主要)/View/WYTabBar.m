//
//  WYTabBar.m
//  沃赢微博
//
//  Created by 闫合 on 16/8/12.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYTabBar.h"
#import "UIView+Extension.h"
@interface WYTabBar()
@property (nonatomic,strong) UIButton *plusButton;
@end
@implementation WYTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.plusButton = [[UIButton alloc]init];
        [self.plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [self.plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [self.plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [self.plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
       self.plusButton.width = self.plusButton.currentBackgroundImage.size.width;
        self.plusButton.height = self.plusButton.currentBackgroundImage.size.height;
        [self addSubview:self.plusButton];
    }
    return self;
}
//设置子控件布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    //plusButton位于标签栏正中间
    self.plusButton.centerX = self.width*0.5;
    self.plusButton.centerY = self.height*0.5;
    CGFloat btnW = self.width/5;
    //NSLog(@"%@",self.subviews);
    int idx = 0;
    for (UIView *view in self.subviews)
    {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class])
        {
            view.x = idx*btnW;
            idx++;
        }
        if (idx==2)
        {
            idx++;
        }
    }

}
@end
