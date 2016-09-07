//
//  AllControlsViewController.m
//  UI02(故事板demo)
//
//  Created by 闫合 on 16/9/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "AllControlsViewController.h"
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
@interface AllControlsViewController ()<UIWebViewDelegate>

@end

@implementation AllControlsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //先添加一个滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1650);
    [self.view addSubview:scrollView];
    //添加一个标签
    CGFloat labelX = 20;
    CGFloat labelY = 10;
    CGFloat labelW = SCREEN_WIDTH-2*labelX;
    CGFloat labelH = 30;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    label.text = @"Label";
    label.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:label];
    //添加一个按钮
    CGFloat buttonX = 20;
    CGFloat buttonY = 10+labelY+labelH;
    CGFloat buttonW = SCREEN_WIDTH-2*buttonX;
    CGFloat buttonH = 30;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:button];
    //添加一个图片视图
    CGFloat imgViewX = 20;
    CGFloat imgViewY = 10+buttonY+buttonH;
    CGFloat imgViewW = SCREEN_WIDTH-2*imgViewX;
    CGFloat imgViewH = imgViewW*0.5;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"IMG_0024.jpg" ofType:nil];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:path]];
    imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    imgView.contentMode = UIViewContentModeRedraw;
    [scrollView addSubview:imgView];
    //添加文本框
    CGFloat textFiledX = 20;
    CGFloat textFiledY = 10+imgViewY+imgViewH;
    CGFloat textFiledW = SCREEN_WIDTH-2*textFiledX;
    CGFloat textFiledH = 30;
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(textFiledX, textFiledY, textFiledW, textFiledH)];
    textFiled.backgroundColor = [UIColor whiteColor];
    textFiled.placeholder = @"TextFiled";
    [scrollView addSubview:textFiled];
    //添加文本域
    
    CGFloat textViewX = 20;
    CGFloat textViewY = 10+textFiledY+textFiledH;
    CGFloat textViewW = SCREEN_WIDTH-2*textViewX;
    CGFloat textViewH = 60;
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(textViewX, textViewY, textViewW, textViewH)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.text = @"TextView";
    [scrollView addSubview:textView];
    //添加开关
    UISwitch *mySwitch = [[UISwitch alloc]init];
    CGRect frame = mySwitch.frame;
    CGFloat switchX = 20;
    CGFloat switchY = 10+textViewY+textViewH;
    frame.origin.x = switchX;
    frame.origin.y = switchY;
    mySwitch.frame = frame;
    mySwitch.on = YES;
    [scrollView addSubview:mySwitch];
    //添加活动指示器
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    frame = indicator.frame;
    CGFloat indicatorX = switchX+20+mySwitch.frame.size.width;
    CGFloat indicatorY = switchY;
    frame.origin.x = indicatorX;
    frame.origin.y = indicatorY;
    indicator.frame = frame;
    [indicator startAnimating];
    [scrollView addSubview:indicator];
    //添加页控件
    CGFloat pageX = 20+indicatorX+indicator.frame.size.width;
    CGFloat pageY = switchY;
    CGFloat pageW = SCREEN_WIDTH-pageX-20;
    CGFloat pageH = 37;
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(pageX, pageY, pageW, pageH)];
    page.numberOfPages = 5;
    [scrollView addSubview:page];
    //添加一个分段控件
    CGFloat segmentX = 20;
    CGFloat segmentY = 20+mySwitch.frame.size.height+switchY;
    CGFloat segmentW = SCREEN_WIDTH-2*segmentX;
    CGFloat segmentH = 28;
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"one",@"two",@"three"]];
    segment.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
    segment.selectedSegmentIndex = 0;
    [scrollView addSubview:segment];
    //添加一个滑块控件
    CGFloat sliderX = 20;
    CGFloat sliderY = 20+segmentY+segmentH;
    CGFloat sliderW = SCREEN_WIDTH-2*sliderX;
    CGFloat sliderH = 30;
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(sliderX, sliderY, sliderW, sliderH)];
    [scrollView addSubview:slider];
    //添加一个进度条
    CGFloat progressX = 20;
    CGFloat progressY = 20+sliderY+sliderH;
    CGFloat progressW = SCREEN_WIDTH-2*progressX;
    CGFloat progressH = 2;
    UIProgressView *progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.frame = CGRectMake(progressX, progressY, progressW, progressH);
    progress.progress = 0.5;
    [scrollView addSubview:progress];
    //添加搜索栏
    CGFloat searchX = 20;
    CGFloat searchY = 20+progressY+progressH;
    CGFloat searchW = SCREEN_WIDTH-2*searchX;
    CGFloat searchH = 44;
    
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(searchX, searchY, searchW, searchH)];
    search.placeholder = @"搜一下";
    //    search.showsScopeBar = NO;
    [scrollView addSubview:search];
    //添加日期选择器
    CGFloat datePickerX = 0;
    CGFloat datePickerY = 10+searchY+searchH;
    CGFloat datePickerW = SCREEN_WIDTH;
    CGFloat datePickerH = 200;
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(datePickerX, datePickerY, datePickerW, datePickerH)];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    [scrollView addSubview:datePicker];
    //添加表视图
    CGFloat tableX = 20;
    CGFloat tableY = 20+datePickerY+datePickerH;
    CGFloat tableW = SCREEN_WIDTH-2*tableX;
    CGFloat tableH = 200;
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStylePlain];
    [scrollView addSubview:table];
    //添加网页视图
    
    CGFloat webY = 20+tableY+tableH;
    CGFloat webW = SCREEN_WIDTH;
    CGFloat webX = 0;
    CGFloat webH = 400;
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(webX, webY, webW, webH)];
    web.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://www.wyzc.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [scrollView addSubview:web];
    //添加一个stepper
    CGFloat stepperY = 20+webY+webH;
    CGFloat stepperW = 94;
    CGFloat stepperX = (SCREEN_WIDTH-stepperW)*0.5;
    CGFloat stepperH = 29;
    UIStepper *stepper = [[UIStepper alloc]initWithFrame:CGRectMake(stepperX, stepperY, stepperW, stepperH)];
    stepper.tintColor = [UIColor whiteColor];
    [scrollView addSubview:stepper];
    //添加一个stackView
    CGFloat stackViewX = 0;
    CGFloat stackViewY = 30+stepperY+stepperH;
    CGFloat stackViewW = SCREEN_WIDTH-2*stackViewX;
    CGFloat stackViewH = 80;
    
    NSArray *imgeviews = [NSArray arrayWithObjects:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gq1"]],[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gq2"]],[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gq3"]],[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gq4"]],[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gq5"]], nil];
    UIStackView *stackView = [[UIStackView alloc]initWithArrangedSubviews:imgeviews];
    stackView.frame = CGRectMake(stackViewX, stackViewY, stackViewW, stackViewH);
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillProportionally;
    [scrollView addSubview:stackView];
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

- (IBAction)tap:(id)sender
{
    [self.view endEditing:YES];
}
@end
