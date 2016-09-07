//
//  ShowFontEffectViewController.m
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "ShowFontEffectViewController.h"
@interface ShowFontEffectViewController ()

@end

@implementation ShowFontEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *text = [YHUtil passString];
    float size = [YHUtil fontSize];
    NSString *fontName = [YHUtil fontName];
    UIColor *fontColor = [YHUtil fontColor];
    self.resultText.text = text;
    self.resultText.font = [UIFont fontWithName:fontName size:size];
    self.resultText.textColor = fontColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


- (IBAction)back:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toFontSetting" sender:self];
}
@end
