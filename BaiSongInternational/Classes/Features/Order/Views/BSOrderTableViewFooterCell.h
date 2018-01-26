//
//  BSOrderTableViewFooterCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSOrderModel.h"

#define BSOrderTableViewFooterCellHeight 75;


@interface BSOrderTableViewFooterCell : UITableViewCell

@property (nonatomic) BSOrderViewType type;

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
