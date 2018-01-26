//
//  BSOrderDetailViewController.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/19.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBaseViewController.h"

#import "BSOrderModel.h"

/***
 *  订单详情
 */

@interface BSOrderDetailViewController : BSBaseViewController

- (instancetype)initWithModel:(BSOrderModel *)model type:(BSOrderViewType)type;

@end
