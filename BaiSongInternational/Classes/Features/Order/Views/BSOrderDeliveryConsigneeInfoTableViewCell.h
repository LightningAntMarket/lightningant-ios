//
//  BSOrderDeliveryConsigneeInfoTableViewCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/15.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSOrderModel.h"

/***
 *  发货---收货人信息
 */


@interface BSOrderDeliveryConsigneeInfoTableViewCell : UITableViewCell



+ (instancetype)cellForTableView:(UITableView *)tableView;

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView;


+ (CGFloat)heightForCellWithModel:(BSOrderModel *)model;

@end
