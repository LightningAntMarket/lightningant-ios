//
//  BSOrderSwitchTopView.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  订单顶部切换view
 **/


//根据不同情况才采取不同布局
typedef NS_ENUM(NSInteger, BSOrderSwitchTopViewType) {
    //我抢过的
    BSOrderSwitchTopViewType_OrderAuction = 1,
    //我送过的
    BSOrderSwitchTopViewType_OrderIssued    = 2,
};

#define BSOrderSwitchTopViewHeight 75.0f

@protocol BSOrderSwitchTopViewDelegate <NSObject>

- (void)orderSwitchTopViewBtnClickByIndex:(NSInteger)index;

@end

@interface BSOrderSwitchTopView : UIView

@property (nonatomic) NSInteger currentIndex;

@property (nonatomic,weak) id<BSOrderSwitchTopViewDelegate> delegate;

- (instancetype)initWithType:(BSOrderSwitchTopViewType)type;

@end
