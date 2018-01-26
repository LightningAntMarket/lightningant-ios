//
//  BSOrderDetailDataTableViewCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/19.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSOrderModel.h"

#define BSOrderDetailDataTableViewCellHeight 290.0f

@interface BSOrderDetailDataTableViewCell : UITableViewCell


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
