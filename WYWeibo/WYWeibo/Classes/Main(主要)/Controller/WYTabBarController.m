//
//  WYTabBarController.m
//  沃赢微博
//
//  Created by 闫合 on 16/8/12.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYTabBarController.h"
#import "WYHomeViewController.h"
#import "WYMessageCenterViewController.h"
#import "WYDiscoverViewController.h"
#import "WYProfileViewController.h"
#import "WYNavigationController.h"
#import "WYTabBar.h"
@interface WYTabBarController ()

@end

@implementation WYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加首页控制器
    WYHomeViewController *homeVc = [[WYHomeViewController alloc]initWithStyle:UITableViewStylePlain];
    [self addChildWithController:homeVc title:@"首页" imgName:@"tabbar_home" selectedImgName:@"tabbar_home_selected"];
    //添加消息控制器
    WYMessageCenterViewController *messageVc = [[WYMessageCenterViewController alloc]init];
    [self addChildWithController:messageVc title:@"消息" imgName:@"tabbar_message_center" selectedImgName:@"tabbar_message_center_selected"];
    //添加广场控制器
    WYDiscoverViewController *discoverVc = [[WYDiscoverViewController alloc]init];
    [self addChildWithController:discoverVc title:@"广场" imgName:@"tabbar_discover" selectedImgName:@"tabbar_discover_selected"];
    //添加我控制器
    WYProfileViewController *profileVc = [[WYProfileViewController alloc]init];
    [self addChildWithController:profileVc title:@"我"imgName:@"tabbar_profile" selectedImgName:@"tabbar_profile_selected"];
    WYTabBar *tabBar = [[WYTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
}
/**
 *  提取代码的原则
    把代码相同的部分放进方法中，不同的部分作为参数来传递
 *
 *
 */
#pragma mark - 设置并添加子视图控制器
-(void)addChildWithController:(UIViewController *)childVc title:(NSString *)title imgName:(NSString *)imgName selectedImgName:(NSString *)selectedImgName
{
    //设置标题
    childVc.tabBarItem.title = title;//标签栏标题
    childVc.navigationItem.title = title;//导航栏标题
    //修改标签栏上文字选中时的颜色
    NSMutableDictionary *fontDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil];
    [childVc.tabBarItem setTitleTextAttributes:fontDict forState:UIControlStateSelected];
    
    childVc.tabBarItem.image = [UIImage imageNamed:imgName];//设置图标
    //设置选中时的图片
    UIImage *img = [UIImage imageNamed:selectedImgName];
    //阻止tab控制器渲染图片
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = img;
    WYNavigationController *nav = [[WYNavigationController alloc]initWithRootViewController:childVc];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    [self addChildViewController:nav];
    
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
