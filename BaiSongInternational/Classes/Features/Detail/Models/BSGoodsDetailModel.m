//
//  BSGoodsDetailModel.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailModel.h"

@implementation BSGoodsDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"sendGoods" : @"sendlog",
             @"joinUsers" : @"joinlog"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"sendGoods" : @"BSGoods",
             @"joinUsers" : @"BSJoinUser",

             };
}

@end
