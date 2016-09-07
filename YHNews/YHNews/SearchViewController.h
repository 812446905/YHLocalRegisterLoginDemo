//
//  SearchViewController.h
//  YHNews
//
//  Created by 闫合 on 16/8/3.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)SearchTap:(id)sender;
- (IBAction)closeKB:(id)sender;
@property (nonatomic,strong) NSMutableArray *news;
@end
