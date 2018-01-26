//
//  BSGoodsDetailJoinCell.h
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSGoodsDetailModel;
@interface BSGoodsDetailJoinCell : UITableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView;

@property (strong , nonatomic) BSGoodsDetailModel *detailModel;

+ (CGFloat)heightForCellWithModel:(BSGoodsDetailModel *)detailModel;

@end
