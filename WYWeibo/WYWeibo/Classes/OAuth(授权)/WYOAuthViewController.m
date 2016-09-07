//
//  WYOAuthViewController.m
//  WYWeibo
//
//  Created by 闫合 on 16/8/15.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "WYOAuthViewController.h"
#import "AFNetworking.h"
#import "WYAccount.h"
#import "WYAccountTool.h"
#import "WYTabBarController.h"
@interface WYOAuthViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation WYOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //client_id	true	string	申请应用时分配的AppKey。
    //redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。http://
   //创建一个网页视图
    _webView = [[UIWebView alloc]init];
    _webView.frame = self.view.bounds;
    NSString *urlPath = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",@"1577730995",@"http://"];
    NSURL *url = [NSURL URLWithString:urlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}
#pragma mark - UIWebViewDelegate方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;// http://
    //NSLog(@"%@",url);//http://localhost/?code=99239c3473fa82f21804cc3cd244487c
    NSRange range = [url rangeOfString:@"code="];
    if (range.length>0)
    {
        NSUInteger idx = range.location+range.length;
        NSString *code = [url substringFromIndex:idx];
        // https://api.weibo.com/oauth2/access_token
        /**
         * 
         
         请求参数          必选	    类型及范围	   说明
         client_id	      true	    string	      申请应用时分配的AppKey。
         client_secret	  true	    string	      申请应用时分配的AppSecret。
         grant_type	       true	    string	      请求的类型，填写authorization_code
         
         grant_type为authorization_code时
                          必选	类型及范围	说明
         code	         true	string	   调用authorize获得的code值。
         redirect_uri	 true	string	   回调地址，需需与注册应用里的回调地址一致。
         */
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1577730995",@"client_id",@"eb43b7de62644192cb4176bf83814e2f",@"client_secret",@"authorization_code",@"grant_type",code,@"code",@"http://",@"redirect_uri", nil];
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        NSString *strUrl = @"https://api.weibo.com/oauth2/access_token";
       [mgr POST:strUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
           //NSLog(@"请求成功，%@",responseObject);
           WYAccount *account = [WYAccount accountWithDict:responseObject];
           [WYAccountTool saveAccount:account];
           WYTabBarController *tabBarVc = [[WYTabBarController alloc]init];
           UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
           keyWindow.rootViewController = tabBarVc;
           [keyWindow makeKeyAndVisible];
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"请求失败，%@",error);
       }];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
