//
//  BSWalletListCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSWalletCache.h"


/**
 *  钱包列表
 **/

#define BSWalletListCellHeight 110.0f

@interface BSWalletListCell : UITableViewCell


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSWalletData *)model tableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
