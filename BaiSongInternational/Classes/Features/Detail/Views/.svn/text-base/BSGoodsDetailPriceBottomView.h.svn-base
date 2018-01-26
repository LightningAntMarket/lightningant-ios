//
//  BSGoodsDetailPriceBottomView.h
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/8.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGoodsDetailModel.h"

#define PriceViewDefaultHeight 290

@class BSGoodsDetailPriceBottomView;

@protocol BSGoodsDetailPriceBottomViewDelegate <NSObject>
//用户出价
- (void)priceView:(BSGoodsDetailPriceBottomView *)priceView buyGoodsWithPrice:(NSString *)price;

@end

@interface BSGoodsDetailPriceBottomView : UIView

@property (weak , nonatomic) id<BSGoodsDetailPriceBottomViewDelegate> delegate;

@property (strong , nonatomic) BSGoodsDetailModel *detailModel;

- (void)showView;
- (void)dismiss;

@end
