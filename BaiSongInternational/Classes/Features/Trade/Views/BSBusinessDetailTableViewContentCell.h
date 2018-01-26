//
//  BSBusinessDetailTableViewContentCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSTradeModel.h"

/***
 *  交易详情--app内部买卖商品
 *  买/卖家头像、昵称、商品图片、文字
 */

#define BSBusinessDetailTableViewContentCellHeiht 110.0f

@interface BSBusinessDetailTableViewContentCell : UITableViewCell



- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel *)model tableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
