//
//  BSTaskTableViewCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTaskModel.h"

/**
 社区--任务列表cell
 */

@interface BSTaskTableViewCell : UITableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView;
- (void)configCellWithModel:(BSTaskModel *)model indexPath:(NSIndexPath *)indexPath;
@end
