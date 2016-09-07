//
//  FontSizeColorViewController.m
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "FontSizeColorViewController.h"
#import "YHUtil.h"
@interface FontSizeColorViewController ()

@end

@implementation FontSizeColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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

- (IBAction)save:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toShow" sender:self];
    [YHUtil setFontSize:(int)self.fontSizeSlider.value];
    NSLog(@"fontSize=%d",(int)[YHUtil fontSize]);
    [YHUtil setFontColor:self.showColorLabel.backgroundColor];
}
- (IBAction)colorChanged:(UISlider *)sender
{
    self.showColorLabel.backgroundColor = [UIColor colorWithRed:self.rSlider.value/255 green:self.gSlider.value/255 blue:self.bSlider.value/255 alpha:1.000];
}
- (IBAction)sizeChanged:(UISlider *)sender
{
    float size = self.fontSizeSlider.value;
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%d",(int)size];
    
}
@end
