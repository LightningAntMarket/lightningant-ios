//
//  BSGoodsDetailPriceCell.h
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSGoods.h"

@interface BSGoodsDetailPriceCell : UITableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView;

@property (strong , nonatomic) BSGoods *goods;
@end
