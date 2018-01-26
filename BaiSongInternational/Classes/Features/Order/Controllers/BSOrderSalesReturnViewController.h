//
//  BSOrderSalesReturnViewController.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/14.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBaseViewController.h"

#import "BSOrderModel.h"


/**
 *  申请退币
 **/


@protocol BSOrderSalesReturnViewControllerDelegate <NSObject>

- (void)needPushMsgWithModel:(BSOrderModel *)model;

@end

@interface BSOrderSalesReturnViewController : BSBaseViewController

@property (nonatomic) id<BSOrderSalesReturnViewControllerDelegate> delegate;

- (instancetype)initWithModel:(BSOrderModel *)model;

@end
