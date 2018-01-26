//
//  BSOrderModel.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderModel.h"
#import "BSLoginManager.h"


//提示
//#define kDay_Snag @"剩%d天收货"
//#define kHour_Snag @"剩%d小时收货???"

//#define kDay_Send @"剩%d天发货??"
//#define kHour_Send @"剩%d小时发货???"

//确认收货
static NSString * GetTakeDelivery = @"Android/TakeDelivery/index/oid/%@";
//同意退币
static NSString * GetGoodsBack = @"Android/GoodsBack/index/oid/%@";
//取消订单
static NSString * GetApplyCancleOrder = @"Android/Order/applyCancleOrder/oid/%@";
//卖方、确认订单
static NSString * GetApplyConfimOrder = @"Android/Order/applyConfimOrder/oid/%@";

@implementation BSOrderModel

- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    

    self.Description = [jsonDic objectForKey:@"description"];
    
    self.fitAddress = [NSString stringWithFormat:@"%@ %@",self.city,self.address];
    
    [self configOrderStatus];
}


- (void)configOrderStatus {
    
//    if ([self.time isEqualToString:@"已发货"]) {
//        self.orderStatus = @"已发货";
//        self.orderStatusImg = @"cell_mine_orderDetail_status_2";
//        return;
//    }
//

    if ([self.ostate intValue] == 0) {
        //进行中
        self.orderStatus = BSLocalizedString(@"in.progress");
        self.orderStatusImg = @"cell_mine_orderDetail_status_1";
    }else if ([self.ostate intValue] == 1) {
        //剩余多久发货  7天
        self.orderStatus = BSLocalizedString(@"to.be.delivered");
        self.orderStatusImg = @"cell_mine_orderDetail_status_1";
    }else if ([self.ostate intValue] == 3) {
        //剩余多久确认收货 14天
        self.orderStatus = BSLocalizedString(@"to.be.received");
        self.orderStatusImg = @"cell_mine_orderDetail_status_2";
    }else if ([self.ostate intValue] == 5) {
        //申请退币
        self.orderStatus = BSLocalizedString(@"return.01");
        self.orderStatusImg = @"cell_mine_orderDetail_status_2";
    
    }else if ([self.ostate intValue] == 7) {
        //交易关闭
        self.orderStatus = BSLocalizedString(@"transaction.closed");
        self.orderStatusImg = @"cell_mine_orderDetail_status_4";
    }else if ([self.ostate intValue] == 9) {
        //交易成功--可评价
        self.orderStatus = BSLocalizedString(@"transaction.finished");
        self.orderStatusImg = @"cell_mine_orderDetail_status_3";
        
    }else if ([self.ostate intValue] == 10) {
        //交易成功--已评价
        self.orderStatus = BSLocalizedString(@"delivered");
        self.orderStatusImg = @"cell_mine_orderDetail_status_2";
        
    }else if ([self.ostate intValue] == 20) {
        //已发货
        self.orderStatus = BSLocalizedString(@"delivered");
        self.orderStatusImg = @"cell_mine_orderDetail_status_2";
        
    }
    
}


- (NSString *)surplusTime:(NSString *)time day:(int)remain isSend:(BOOL) isSend
{
    if (time.length == 0) {
        return @"";
    }
    
    //当前时间
    NSDate * nowDate = [NSDate date];
    NSDate * aDate = [NSDate dateWithTimeIntervalSince1970:time.floatValue];
    NSTimeInterval timeInter = remain*24*60*60 - [nowDate timeIntervalSinceDate:aDate];
    
    int day = (int)timeInter/(24*3600);
    int hour = ((int)timeInter - day*24*3600)/3600;
    
    NSString *D_Str,*H_Str;
    
    if (isSend) {
        D_Str = BSLocalizedString(@"days.left.for.delivery");
        H_Str = BSLocalizedString(@"hours.left.for.delivery");
    }else{
        D_Str = BSLocalizedString(@"days.left.for.automatic.receiving");
        H_Str = BSLocalizedString(@"hours.left.for.automatic.receiving");
    }
    
    if (day>0) {
        
        NSString * returnTime = [NSString stringWithFormat:D_Str,day];
        return returnTime;
    }else if (day == 0 && hour > 0){
        
        NSString * returnTime = [NSString stringWithFormat:H_Str,hour];
        return returnTime;
    }
    return BSLocalizedString(@"data.error");
    
}

- (BOOL)checkSendGoodInfo {
    if (self.express_number.length > 0 && self.express_company.length > 0) {
        return true;
    }else {
        return false;
    }
}

- (BOOL)isSended {
    return ([self.ostate intValue] >= 3);
}

- (void)setShowModifyBtn:(BOOL)showModifyBtn {
    _showModifyBtn = showModifyBtn;
    if ([self.modetype intValue] == 2 && showModifyBtn) {
        //一口价
        _showModifyBtn = YES;
    }else {
        _showModifyBtn = NO;
    }
}

- (void)configSendDataWithDic:(NSDictionary *)dic {
    
    BSOrderModel * model = [[BSOrderModel alloc]initContentWithDic:dic];
    
    self.express_company = model.express_company;
    self.express_number = model.express_number;
    self.consignee = model.consignee;
    self.mobile = model.mobile;
    self.fitAddress = model.fitAddress;
    self.time = model.time;
    self.ostate = model.ostate;
}


- (void)sendOver {
    self.ostate = @"20";
//    self.time = @"已发货";
//    [self configOrderStatus];
}

- (void)setOstate:(NSString *)ostate {
    _ostate = ostate;
    [self configOrderStatus];
}



#pragma mark - network
- (void)getTakeDeliveryBlc:(TakeDeliveryBlc)block {
    
    NSString * url = [NSString stringWithFormat:GetTakeDelivery,self.oid];
    
    //拼接区块链privkey
    NSString * privkey = [[BSDataBaseManager shareInstance] getUserInfo].privkey;
    if (!privkey) {
        return;
    }
    url = [NSString stringWithFormat:@"%@/privkey/%@",url,privkey];
    
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        if ([json[@"status"] intValue] == 1) {
            self.ostate = @"9";
            block(nil);
        }else {
            [self showHint:json[@"msg"]];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-101
                                             userInfo:json];
            block(error);
        }
    } failure:^(NSError *error) {
        [self showHint:BSLocalizedString(@"failed.please.try.again")];
        block(error);
    }];
}

- (void)getGoodsBack:(GetGoodsBackBlc)block {
    NSString * url = [NSString stringWithFormat:GetGoodsBack,self.oid];
    
    //拼接区块链privkey
    NSString * privkey = [[BSDataBaseManager shareInstance] getUserInfo].privkey;
    if (!privkey) {
        return;
    }

    url = [NSString stringWithFormat:@"%@/privkey/%@",url,privkey];
    
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        if ([json[@"status"] intValue] == 1) {
            
            self.ostate = @"7";
            block(nil);
        }else {
            
            
            [self showHint:json[@"msg"]];
            
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-101
                                             userInfo:json];
            block(error);
        }
    } failure:^(NSError *error) {
        [self showHint:BSLocalizedString(@"failed.please.try.again")];
        block(error);
    }];
}


- (void)GetGoodsCancel:(GetGoodsCancelBlc)block {
    NSString * url = [NSString stringWithFormat:GetApplyCancleOrder,self.oid];
    
    //拼接区块链privkey
   NSString * privkey = [[BSDataBaseManager shareInstance] getUserInfo].privkey;
    if (!privkey) {
        return;
    }
    
    url = [NSString stringWithFormat:@"%@/privkey/%@",url,privkey];
    
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        if ([json[@"status"] intValue] == 1) {
            
            self.ostate = @"7";
            block(nil);
        }else {
            
            
            [self showHint:json[@"msg"]];
            
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-101
                                             userInfo:json];
            block(error);
        }
    } failure:^(NSError *error) {
        [self showHint:BSLocalizedString(@"failed.please.try.again")];
        block(error);
    }];
}


- (void)GetTakeDeliverySeller:(GetTakeDeliverySellerBlc)block{
    NSString * url = [NSString stringWithFormat:GetApplyConfimOrder,self.oid];
    
    //拼接区块链privkey
    NSString * privkey = [[BSDataBaseManager shareInstance] getUserInfo].privkey;
    if (!privkey) {
        return;
    }
    
    url = [NSString stringWithFormat:@"%@/privkey/%@",url,privkey];
    
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        if ([json[@"status"] intValue] == 1) {
            
            self.ostate = @"9";
            block(nil);
        }else {
            
            
            [self showHint:json[@"msg"]];
            
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-101
                                             userInfo:json];
            block(error);
        }
    } failure:^(NSError *error) {
        [self showHint:BSLocalizedString(@"failed.please.try.again")];
        block(error);
    }];
}

@end


