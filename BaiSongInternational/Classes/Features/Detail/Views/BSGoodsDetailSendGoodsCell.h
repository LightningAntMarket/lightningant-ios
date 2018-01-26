//
//  BSGoodsDetailSendGoodsCell.h
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGoods.h"

@protocol BSGoodsDetailSendGoodsCellDelegate<NSObject>
//如果实现了代理的话----加载更多
- (void)needLoadMoreData;
@end

@interface BSGoodsDetailSendGoodsCell : UITableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView;

@property (strong , nonatomic) NSArray<BSGoods *> *dataArr;


@property (weak , nonatomic) id<BSGoodsDetailSendGoodsCellDelegate> delegate;

@end
