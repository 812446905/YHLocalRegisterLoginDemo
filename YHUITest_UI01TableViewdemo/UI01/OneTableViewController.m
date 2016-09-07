//
//  OneTableViewController.m
//  UI01
//
//  Created by 闫合 on 16/8/29.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "OneTableViewController.h"
@interface OneTableViewController ()

@end

@implementation OneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //创建一个标签
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 70)];
    titleLabel.text = @"表格一";//标签显示文本
    titleLabel.textAlignment = NSTextAlignmentCenter;//文本中心对齐
    titleLabel.font = [UIFont systemFontOfSize:22];//字号
    titleLabel.backgroundColor = [UIColor colorWithRed:0.502 green:0.251 blue:0.000 alpha:1.000];//标签背景色
    //将此标签放在表头视图
   self.tableView.tableHeaderView = titleLabel;
    //让表视图cell的分割线从屏幕最左边开始显示
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView  respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 500;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    // Configure the cell...
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"This is Cell %ld",indexPath.row];
    //更改cell的高度和宽度
    CGRect frame = cell.frame;
    frame.size.height = 60;
    frame.size.width = self.tableView.frame.size.width;
    cell.frame = frame;
    //右边加一个按钮
    CGFloat cellBtnY = 10;
    CGFloat cellBtnW = 120;
    CGFloat cellBtnH = cell.frame.size.height-2*cellBtnY;
    CGFloat cellBtnX = cell.frame.size.width-cellBtnW-40;
     UIButton *cellBtn = [[UIButton alloc]initWithFrame:CGRectMake(cellBtnX, cellBtnY, cellBtnW, cellBtnH)];
    //按钮背景色
    cellBtn.backgroundColor = [UIColor whiteColor];
    cellBtn.layer.cornerRadius = 0.25*cellBtnH;//按钮倒角半径
    [cellBtn setTitle:[NSString stringWithFormat:@"button%ld",indexPath.row+1] forState:UIControlStateNormal];//按钮显示文本
    //按钮文本颜色
    [cellBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //添加到单元格
    [cell addSubview:cellBtn];
    //单元格附件类型
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //单元格背景色
    cell.backgroundColor = [UIColor colorWithRed:0.502 green:0.251 blue:0.000 alpha:1.000];
    return cell;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
