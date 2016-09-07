//
//  ShowViewController.m
//  YHNews
//
//  Created by 闫合 on 16/8/2.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "ShowViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
@interface ShowViewController ()
@property (nonatomic,strong) NSString *saveTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *right;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    FMDatabase *db = app.db;
    NSString *sql = [NSString stringWithFormat:@"select count(*) from saves where idid=%@",_news.idid];
    FMResultSet *rs = [db executeQuery:sql];
    [rs next];
    int rsCount = [rs intForColumnIndex:0];
    if (rsCount>0)
    {
        _right.title = @"取消收藏";
    }
    else
    {
       _right.title = @"收藏";
    }
    
    self.navigationItem.rightBarButtonItem = _right;

}
- (IBAction)SaveTap:(UIBarButtonItem *)sender
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    FMDatabase *db = app.db;
    UIImage *img = _news.img;
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    /*
        NSString *sql = [NSString stringWithFormat:@"select pic from news where idid=%@",_news.idid];
        FMResultSet *rs = [db executeQuery:sql];
        [rs next];
        NSData *data = [rs dataForColumn:@"pic"];
     */
    //判断是否已经收藏
    NSString *sql = [NSString stringWithFormat:@"select count(*) from saves where idid=%@",_news.idid];
    FMResultSet *rs = [db executeQuery:sql];
    [rs next];
    int rsCount = [rs intForColumnIndex:0];
    if (rsCount>0)//如果本条新闻已经收藏，则点击按钮，文本变为"收藏"，从数据库中删除该新闻，即完成取消收藏功能
    {
        //        //NSLog(@"本条新闻已经收藏过了！");
        //        [SVProgressHUD showInfoWithStatus:@"👎🏿瞅你那损色，已经收藏过！"];
        //        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        //        [SVProgressHUD dismissWithDelay:1.5];
        
        BOOL b=[db executeUpdate:@"delete from saves where idid=?",_news.idid];
        if (!b)
        {
            NSLog(@"删除数据错误！");
        }
        _right.title = @"收藏";
        [SVProgressHUD showSuccessWithStatus:@"取消收藏！"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD dismissWithDelay:1.5];
        
    }
    else//没有收藏过
    {
        BOOL b=[db executeUpdate:@"insert into saves(idid,title,subtitle,picture,content,author,flid,time,clicks,pic) values(?,?,?,?,?,?,?,?,?,?)",_news.idid,_news.title,_news.subtitle,_news.picture,_news.content,_news.author,_news.flid,_news.time,_news.clicks,data];
        if (!b)
        {
            NSLog(@"插入数据错误（detail）！");
        }
        [SVProgressHUD showSuccessWithStatus:@"收藏成功！"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD dismissWithDelay:1.5];
        _right.title = @"取消收藏";
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    _titleText.text = _news.title;
    _subtitleText.text = _news.author;
    _contentText.text = _news.content;
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

@end
