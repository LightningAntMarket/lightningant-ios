//
//  BSDetailOfTransferTableViewTitleCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/27.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTradeModel.h"

/**
 *  转币--app内资产转移
 *  title
 */

#define BSDetailOfTransferTableViewTitleCellHeight 100.0f

@interface BSDetailOfTransferTableViewTitleCell : UITableViewCell


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel *)model tableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
