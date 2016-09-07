//
//  WYNewFeatureViewController.m
//  沃赢微博
//
//  Created by 闫合 on 16/8/12.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYNewFeatureViewController.h"
#import "WYTabBarController.h"
@interface WYNewFeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation WYNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = self.view.bounds;
    for (int i=0; i<4; i++)
    {
        //创建图片
        NSString *imgName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        UIImage *img = [UIImage imageNamed:imgName];
        //创建图片视图
        UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
        imgView.width = self.view.width;
        imgView.height = self.view.height;
        imgView.origin = CGPointMake(i*SCREEN_WIDTH, 0);
        //把图片视图添加到滚动视图上
        [_scrollView addSubview:imgView];
        if (i==3)//在最后一个视图上
        {
            [self addButtonWithImageView:imgView];
        }
    }
    //设置需要滚动的内容的范围
    _scrollView.contentSize = CGSizeMake(4*SCREEN_WIDTH, _scrollView.height);
    //设置
    //_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置分页滚动
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    _pageControl = [[UIPageControl alloc]init];
    //设置页控件的位置
    _pageControl.centerX = self.view.width*0.5;
    _pageControl.centerY = self.view.height-50;
    //设置分页总数
    _pageControl.numberOfPages = 4;
    //设置当前页的指示器颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    //设置其他页的指示器颜色
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_pageControl];
    _scrollView.delegate = self;
}
-(void)addButtonWithImageView:(UIImageView *)imgView
{
    UIButton *checkBoxButton = [[UIButton alloc]init];
    //checkBoxButton.centerX = self.view.width*0.5;
    checkBoxButton.centerY = self.view.height-200;
    checkBoxButton.height = 50;
    checkBoxButton.width = self.view.width;
    [checkBoxButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBoxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBoxButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBoxButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkBoxButton addTarget:self action:@selector(checkBoxTap:) forControlEvents:UIControlEventTouchUpInside];
    checkBoxButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    imgView.userInteractionEnabled = YES;//允许和用户进行交互
    [imgView addSubview:checkBoxButton];
    //添加开始微博按钮
    UIButton *startWeibo = [[UIButton alloc]init];
    startWeibo.width = 105;
    startWeibo.height = 36;
    startWeibo.centerX = self.view.width*0.5;
    startWeibo.centerY = self.view.height-130;
    [startWeibo setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startWeibo setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startWeibo setTitle:@"开始微博" forState:UIControlStateNormal];
    [startWeibo addTarget:self action:@selector(startTap) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:startWeibo];
}
-(void)startTap
{
    NSLog(@"开始微博...");
    WYTabBarController *rootController = [[WYTabBarController alloc]init];
    //获取应用程序的主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = rootController;
}
/**
 *  对当前按钮的状态进行取反
 *
 *  @param btn
 */
-(void)checkBoxTap:(UIButton *)btn
{
    NSLog(@"按钮点击了");
    btn.selected = !btn.isSelected;
}
#pragma mark - UIScrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offSet = scrollView.contentOffset;
    NSLog(@"%g",offSet.x);
    CGFloat pageIndex = (offSet.x+self.view.width*0.5)/self.view.width;
    _pageControl.currentPage = pageIndex;
}
#pragma mark -
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
