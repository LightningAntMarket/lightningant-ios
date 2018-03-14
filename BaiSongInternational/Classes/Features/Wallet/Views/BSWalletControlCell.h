//
//  BSWalletControlCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSWalletCache.h"

/**
 *  钱包操作
 *  提现、交易记录、查看私钥、切换钱包
 **/


#define BSWalletControlCellHeight 75.0f

@interface BSWalletControlCell : UITableViewCell


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSWalletData *)model tableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;


@end
