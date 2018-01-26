//
//  BSBusinessDetailViewController.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBaseViewController.h"
#import "BSTradeModel.h"

/***
 *  交易详情--app内部转账
 */

@interface BSBusinessDetailViewController : BSBaseViewController


- (instancetype)initWithModel:(BSTradeModel *)model;
@end
