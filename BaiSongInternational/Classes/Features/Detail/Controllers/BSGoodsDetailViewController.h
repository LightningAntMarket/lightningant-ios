//
//  BSGoodsDetailViewController.h
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBaseViewController.h"
#import "BSGoods.h"

@interface BSGoodsDetailViewController : BSBaseViewController

- (instancetype)initWithGid:(NSString *)gid;

- (instancetype)initWithModel:(BSGoods *)model;

@end
