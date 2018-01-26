//
//  BSGoodsDetailBottomView.h
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/1.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGoodsDetailModel.h"

@class BSGoodsDetailBottomView;

@protocol  BSGoodsDetailBottomViewDelegate<NSObject>

- (void)bottomView:(BSGoodsDetailBottomView *)bottomView didClickButton:(UIButton *)button;

@end

@interface BSGoodsDetailBottomView : UIView

@property (weak , nonatomic) id<BSGoodsDetailBottomViewDelegate> delegate;

@property (strong , nonatomic) BSGoodsDetailModel *detailModel;

@end
