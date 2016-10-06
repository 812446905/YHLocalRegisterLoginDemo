//
//  YHApps.m
//  iappfree
//
//  Created by 闫合 on 2016/10/5.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "YHApps.h"

@implementation YHApps
-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.appName = dict[@"name"];
        self.appDescription = dict[@"description"];
        self.appCategory = dict[@"categoryName"];
        self.originalPrice = dict[@"lastPrice"];
        self.starLevel = dict[@"starOverall"];
        self.expireDate = dict[@"expireDatetime"];
        self.downloadCount = dict[@"downloads"];
        self.shareCount = dict[@"shares"];
        self.favoriteCount = dict[@"favorites"];
        self.fileSize = dict[@"fileSize"];
        self.iconUrl = dict[@"iconUrl"];
        self.itunesUrl = dict[@"itunesUr"];
//        [self setValuesForKeysWithDictionary:dict];//用字典键值设置对象属性
    }
    return self;
}
+(instancetype)appModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
-(UIImage *)getIconWithUrlString:(NSString *)strUrl
{
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data)
    {
        _icon = [UIImage imageWithData:data];
    }
    return _icon;
}
@end
