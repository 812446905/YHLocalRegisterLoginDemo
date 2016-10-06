//
//  YHApps.h
//  iappfree
//
//  Created by 闫合 on 2016/10/5.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 "applicationId": "455680974",
 "name": "节奏重复",
 "description": "界面清新简单的音乐节奏游戏。游戏的操作非常简单，只需根据提示依次点击相应的图标即可，共有三种乐曲选择。",
 "categoryName": "Game",
 "iconUrl": "http://photo.candou.com/i/114/55b07f3725eae8b3cafc9bce10d16e46",
 "itunesUrl": "http://itunes.apple.com/cn/app/rhythm-repeat/id455680974?mt=8",
 "starCurrent": "4.0",
 "starOverall": "4.0",
 "downloads": "4999",
 "currentPrice": "0",
 "lastPrice": "12",
 "priceTrend": "limited",
 "expireDatetime": "2016-10-05 10:14:22.0",
 "fileSize": "16.69",
 "shares": "390",
 "favorites": "273"
 */
@interface YHApps : NSObject

/**
 app编号
 */
@property (strong, nonatomic) NSNumber *appId;

/**
 app名称
 */
@property (strong, nonatomic) NSString *appName;

/**
 app简介
 */
@property (strong, nonatomic) NSString *appDescription;

/**
 app类别
 */
@property (strong, nonatomic) NSString *appCategory;

/**
 app图标
 */
@property (strong, nonatomic)  UIImage *icon;

/**
 app原价
 */
@property (strong, nonatomic) NSNumber *originalPrice;

/**
 价格趋势，是限免还是优惠还是免费
 */
@property (strong, nonatomic) NSString *priceTrend;

/**
 app图标URL字符串
 */
@property (strong, nonatomic) NSString *iconUrl;

/**
 app下载链接url字符串
 */
@property (strong, nonatomic) NSString *itunesUrl;
/**
 app星级
 */
@property (strong, nonatomic) NSNumber *starLevel;

/**
 限免到期时间
 */
@property (strong, nonatomic) NSString *expireDate;

/**
 app被下载次数
 */
@property (strong, nonatomic) NSNumber *downloadCount;

/**
 app被分享次数
 */
@property (strong, nonatomic) NSNumber *shareCount;

/**
 app被收藏次数
 */
@property (strong, nonatomic) NSNumber *favoriteCount;

/**
 app安装文件大小
 */
@property (strong, nonatomic) NSNumber *fileSize;

/**
 提供一个字典转模型的对象方法
 */
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)appModelWithDict:(NSDictionary *)dict;

/**
 获取图标
 */
-(UIImage *)getIconWithUrlString:(NSString *)strUrl;
@end
