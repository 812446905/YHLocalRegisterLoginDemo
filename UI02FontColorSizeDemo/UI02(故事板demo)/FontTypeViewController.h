//
//  FontTypeViewController.h
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontTypeViewController : UITableViewController
/**
 *  字体库数组
 */
@property (nonatomic,strong) NSMutableArray *fontNames;
/**
 *  字体名称
 */
@property (nonatomic,copy) NSString *familyName;

@end
