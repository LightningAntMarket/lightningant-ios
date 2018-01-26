//
//  BSTradeWalletOptionView.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

/***
 *  钱包---查看私钥、转币、收币按钮
 */
#import "BSTradeModel.h"

#define BSTradeWalletOptionViewHeight 105.0f

@interface BSTradeWalletOptionView : UIView
@property (nonatomic) BSTradeModel * model;
@end
