//
//  BSTaskDetailGuideTableViewCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTaskModel.h"

/**
 任务详情--流程cell--有图
 */

@interface BSTaskDetailGuideTableViewCell : UITableViewCell

@property (nonatomic) UIImageView * rowImgView;
@property (nonatomic) UILabel * rowNumLab;
@property (nonatomic) UILabel * descLab;
@property (nonatomic) UIImageView *picImgView;

+ (instancetype)cellForTableView:(UITableView *)tableView;

- (void)configCellWithModel:(BSTsakExeStepModel *)model indexPath:(NSIndexPath *)indexPath;
@end
