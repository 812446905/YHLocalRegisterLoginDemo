//
//  YHNews.h
//  我赢新闻
//
//  Created by 闫合 on 16/8/1.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 
 author=
 2016-08-01 16:51:49.630 我赢新闻[87187:12394831] content=
 2016-08-01 16:51:49.630 我赢新闻[87187:12394831] subtitle=
 2016-08-01 16:51:49.630 我赢新闻[87187:12394831] id=
 2016-08-01 16:51:49.630 我赢新闻[87187:12394831] flid=
 2016-08-01 16:51:49.630 我赢新闻[87187:12394831] title=
 2016-08-01 16:51:49.631 我赢新闻[87187:12394831] picture=
 2016-08-01 16:51:49.631 我赢新闻[87187:12394831] time=
 2016-08-01 16:51:49.631 我赢新闻[87187:12394831] clicks=
 */
@interface YHNews : NSObject
@property (nonatomic,strong) NSNumber *clicks;
@property (nonatomic,strong) NSString *picture;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSNumber *idid;
@property (nonatomic,strong) NSNumber *flid;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subtitle;
@property (nonatomic,strong) UIImage *img;
@end
