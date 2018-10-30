//
//  BSTaskPublishGuideCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/7.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTaskPublishDataSource.h"

@protocol BSTaskPublishGuideCellDelegate <NSObject>

- (void)delImgWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface BSTaskPublishGuideCell : UITableViewCell

@property(nonatomic, weak) id<BSTaskPublishGuideCellDelegate> delegate;

+ (instancetype)cellForTableView:(UITableView *)tableView;

- (void)configCellWithModel:(BSTaskPublishGuideModel *)model indexPath:(NSIndexPath *)indexPath;


@end
