//
//  FontTypeViewController.m
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "FontTypeViewController.h"
#import "YHUtil.h"
@interface FontTypeViewController ()

@end

@implementation FontTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //获取所有字体
    NSArray *array = [UIFont familyNames];
    
    self.fontNames = [NSMutableArray array];
    
    //遍历字体数组
    for(NSString *familyName in array)
    {
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        
        [self.fontNames addObjectsFromArray:names];
        
    }
    //NSLog(@"%@",self.fontNames);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.fontNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    self.familyName = self.fontNames[indexPath.row];
        if (indexPath.row%2==0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Ycell"];
            if (cell==nil)
            {
                 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ycell"];
               
            }
            UILabel *label = [cell.contentView.subviews firstObject];
            label.font = [UIFont fontWithName:self.familyName size:18];
        }
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Gcell"];
            if (cell==nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Gcell"];
            }
            UILabel *label = [cell.contentView.subviews firstObject];
            label.font = [UIFont fontWithName:self.familyName size:18];
        }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toFontSizeColor" sender:self];
    [YHUtil setFontName: self.fontNames[indexPath.row]];
    NSLog(@"fontName=%@",[YHUtil fontName]);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
