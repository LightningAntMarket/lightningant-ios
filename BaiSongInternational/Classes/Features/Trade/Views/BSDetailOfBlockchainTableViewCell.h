//
//  BSDetailOfBlockchainTableViewCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTradeModel.h"


#define BSDetailOfBlockchainTableViewCellHeight 100.0f

@interface BSDetailOfBlockchainTableViewCell : UITableViewCell


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(id)model tableView:(UITableView *)tableView;

+ (instancetype)cellForTableView:(UITableView *)tableView;


+ (CGFloat)heightForCellWithModel:(BSTradeModel *)model indexPath:(NSIndexPath *)indexPath;
@end
