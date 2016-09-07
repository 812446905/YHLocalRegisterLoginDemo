//
//  RootViewController.m
//  UI01
//
//  Created by 闫合 on 16/8/29.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "RootViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface RootViewController ()
/**
 *  选中项底部红色线条视图
 */
@property (nonatomic,strong) UIView *indicatorsView;
/**
 *  选中按钮视图
 */
@property (nonatomic,strong) UIView *buttonsView;
/**
 *  页控件
 */
@property (nonatomic,strong) UIPageControl *pc;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   设置导航栏标题
    self.title = @"首页";
//  导航栏下方创建三个按钮
    [self createSelectedButtons];
//  选项按钮下方创建一个滚动视图,放三个表视图水平滚动
    
    [self addTableViewToScrollView];
    
}
/**
 *  创建选中项按钮和底部红线
 */
-(void)createSelectedButtons
{
    //定制按钮frame
    CGFloat buttonW= SCREEN_WIDTH/3;
    CGFloat buttonH = 60;
    CGFloat buttonY = 64;
    //创建按钮视图
    self.buttonsView = [[UIView alloc]initWithFrame:CGRectMake(0, buttonY, SCREEN_WIDTH, buttonH)];
    [self.view addSubview:self.buttonsView];
    NSArray *btnTitleArray = @[@"视图一",@"视图二",@"视图三"];//按钮文本数组
    //创建选中项底部红色线条视图
    self.indicatorsView = [[UIView alloc]initWithFrame:CGRectMake(0, buttonY+buttonH-2, SCREEN_WIDTH, 3)];
    [self.view addSubview:self.indicatorsView];
    for (int i=0; i<3; i++)
    {
        //创建选中项按钮
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*buttonW, 0, buttonW, buttonH)];
        //设置tag
        button.tag = i+1;
        //设置按钮显示文本
        [button setTitle:btnTitleArray[i] forState:UIControlStateNormal];
        //设置按钮文本字体大小
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        //设置按钮文本颜色
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //监听按钮事件
        [button addTarget:self action:@selector(showTableView:) forControlEvents:UIControlEventTouchUpInside];
        //将按钮添加到选中项按钮视图上
        [self.buttonsView addSubview:button];
        //创建选中项底部红色线条
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*buttonW, 0, buttonW, 3)];
        line.backgroundColor = [UIColor redColor];//设置线条颜色
        line.hidden = YES;//线条状态为隐藏
        line.tag = 10*button.tag;
        [self.indicatorsView addSubview:line];//将线条添加到红色线条视图上
    }
    //将第一个按钮项和其底部线条设置为选中状态
    UIButton *btn1 = self.buttonsView.subviews[0];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIView *line1 = self.indicatorsView.subviews[0];
    line1.hidden = NO;

}
/**
 *  添加表视图到滚动视图
 */
-(void)addTableViewToScrollView
{
    //定制滚动视图frame
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = self.buttonsView.frame.origin.y+self.buttonsView.frame.size.height;
    CGFloat scrollViewW = SCREEN_WIDTH;
    CGFloat scrollViewH = SCREEN_HEIGHT-scrollViewY;
    //创建滚动视图
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH)];
    //将滚动视图添加到主视图
    [self.view addSubview:self.scrollView];
    //创建三个表视图放在滚动视图上
    //创建表格一
    self.oneVC = [[OneTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.oneVC.tableView.frame = CGRectMake(0, 0, scrollViewW, scrollViewH);//设置frame
    
    [self.scrollView addSubview:self.oneVC.tableView];//添加表到滚动视图
    //创建表格二
    self.twoVC = [[TwoTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.twoVC.tableView.frame = CGRectMake(scrollViewW, 0, scrollViewW, scrollViewH);//设置frame
    [self.scrollView addSubview:self.twoVC.tableView];//添加表到滚动视图
    
    
    //创建第表格三
    self.threeVC = [[ThreeTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.threeVC.tableView.frame = CGRectMake(scrollViewW*2, 0, scrollViewW, scrollViewH);//设置frame
    [self.scrollView addSubview:self.threeVC.tableView];//添加表到滚动视图
    //设置滚动视图的相关属性
    self.scrollView.contentSize = CGSizeMake(scrollViewW*3, scrollViewH);//设置滚动范围
    self.scrollView.pagingEnabled = YES;//设置以页的形式滚动
    self.scrollView.showsHorizontalScrollIndicator = NO;//不显示水平滚动条
    self.scrollView.bounces = NO;//设置不回弹
    self.scrollView.delegate = self;//设定滚动视图代理
    //创建一个页控件
    self.pc = [[UIPageControl alloc]init];
    self.pc.numberOfPages = 3;//设定页数
    self.pc.currentPage = 0;//设定当前所在的页
    [self.view addSubview:self.pc];//添加页控件到主视图

}
/**
 * 监听滚动视图滚动
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;//偏移量
    //计算在哪个页
    NSInteger pageIndex = (offset.x+0.5*self.view.frame.size.width)/self.view.frame.size.width;
    self.pc.currentPage = pageIndex;//设定当前到哪页
     // 设定选项按钮和红色线条的选中状态
    [self setSelectedButtonAndLineStateWitButtonTag:pageIndex+1];
}
/**
 *  选中项按钮点击事件
 */
-(void)showTableView:(UIButton *)button
{
    //水平滚动范围
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*(button.tag-1), 0);
    // 设定选项按钮和红色线条的选中状态
    [self setSelectedButtonAndLineStateWitButtonTag:button.tag];

}
/**
 *  设定选项按钮和红线的选中状态
 */
-(void)setSelectedButtonAndLineStateWitButtonTag:(NSInteger)tag
{

    for (UIView *views in self.indicatorsView.subviews)
    {
        views.hidden = YES;//隐藏视图（红线）
    }
    [self.indicatorsView viewWithTag:tag*10].hidden = NO;//显示（红线）
    
    for (UIButton *btn in self.buttonsView.subviews)
    {
        //设置按钮文本颜色
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [[self.buttonsView viewWithTag:tag] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
