//
//  BSTransactionModel.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BaseModel.h"



@interface BSTradeModel : BaseModel


typedef void(^blockSendCallback)(NSError * err);

//钱包页
@property (nonatomic,copy) NSString * balance;
@property (nonatomic,copy) NSString * lockbalance;


//交易记录
@property (nonatomic,copy) NSString * qty;
@property (nonatomic) BOOL isfee;
@property (nonatomic,copy) NSString * myaddresses;
@property (nonatomic,copy) NSString * addresses;
@property (nonatomic,copy) NSString * txid;
@property (nonatomic,copy) NSString * time;
/* uid。app内转账则存在 */
@property (nonatomic,copy) NSString * uid;
/* 备注。app内转账则可能存在 */
@property (nonatomic,copy) NSString * msg;
@property (nonatomic,copy) NSString * timereceived;

@property (nonatomic,copy) NSString * face;
@property (nonatomic,copy) NSString * nickname;


//提币用
@property (nonatomic ,copy) NSString * send_to;
@property (nonatomic ,copy) NSString * send_num;

- (BOOL)checkSendData;

//区块链转币
- (void)blockSend:(blockSendCallback)callback;
@end
