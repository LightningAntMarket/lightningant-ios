//
//  BSDeliveryAddressView.h
//  YiBaiSong
//
//  Created by rjhx on 16/8/24.
//  Copyright © 2016年 yibaisong. All rights reserved.
//

#import "BSPopupView.h"
@class BSDefaultAddressView ;

@interface BSDefaultAddress : BaseModel

@property (strong , nonatomic) NSString *address;
@property (strong , nonatomic) NSString *uid;
@property (strong , nonatomic) NSString *phone;
@property (strong , nonatomic) NSString *ID;
@property (strong , nonatomic) NSString *consignee;
@property (strong , nonatomic) NSString *is_default;
@property (strong , nonatomic) NSString *city;
@property (strong , nonatomic) NSString *price;

@end

@protocol BSDefaultAddressViewDelegate <NSObject>

- (void)addressView:(BSDefaultAddressView *)addressView didPressStatus:(BOOL)pressStatus address:(BSDefaultAddress *)addressModel;

@end

@interface BSDefaultAddressView : BSPopupView

@property (weak , nonatomic) id<BSDefaultAddressViewDelegate> delegate;

- (void)configureViewWithDic:(NSDictionary *)dic;

@end


