//
//  BSTaskPublishTableFooterCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/8.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTaskPublishDataSource.h"

@protocol BSTaskPublishTableFooterCellDelegate<NSObject>
- (void)payBtnClick;
@end;

@interface BSTaskPublishTableFooterCell : UITableViewCell
@property (nonatomic, weak) id<BSTaskPublishTableFooterCellDelegate> delegate;

+ (instancetype)cellForTableView:(UITableView *)tableView;

- (void)configCellWithPublishHelper:(BSTaskPublishHelper *)dataSource indexPath:(NSIndexPath *)indexPath;
@end
