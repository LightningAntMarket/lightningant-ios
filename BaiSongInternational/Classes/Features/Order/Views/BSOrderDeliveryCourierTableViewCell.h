//
//  BSOrderDeliveryCourierTableViewCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/15.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSOrderModel.h"

/***
 *  发货---物流公司、物流单号cell
 */


#define BSOrderDeliveryCourierTableViewCellHeight 120.0f

@interface BSOrderDeliveryCourierTableViewCell : UITableViewCell


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
