//
//  BSTransactionModel.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeModel.h"

#import "NSString+Extend.h"
#import "BSLoginManager.h"

//区块链--提币
static NSString * PostBlockSend = @"Android/Block/send";

@implementation BSTradeModel

- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    
    
    if ([jsonDic[@"qty"] isKindOfClass:[NSString class]]) {
        self.qty = jsonDic[@"qty"];
    }
    
    if ([jsonDic[@"qty"] isKindOfClass:[NSNumber class]]) {
        self.qty = [NSString stringWithFormat:@"%@",jsonDic[@"qty"]];
    }
    
    
    id data = jsonDic[@"data"];
    if ([data isKindOfClass:[NSArray class]]) {
        if (((NSArray *)data).count == 1) {
            self.isfee = YES;
        }else if (((NSArray *)data).count == 2){
            self.uid = [(jsonDic[@"data"][0]) convertHexStrToString] ;
            self.msg = [[(jsonDic[@"data"][1]) convertHexStrToString] stringByRemovingPercentEncoding];
        }
    }
    
    if ([jsonDic[@"myaddresses"] isKindOfClass:[NSArray class]] && ((NSArray *)(jsonDic[@"myaddresses"])).count) {
        self.myaddresses = jsonDic[@"myaddresses"][0];
    }
    
    if ([jsonDic[@"addresses"] isKindOfClass:[NSArray class]] && ((NSArray *)(jsonDic[@"addresses"])).count) {
        self.addresses = jsonDic[@"addresses"][0];
    }
}



//提币用
- (BOOL)checkSendData {
    BOOL check = NO;
    
    if (self.send_to.length && self.send_num.length) {
        check = YES;
    }else {
        check = NO;
    }
    
    if ([self.send_num intValue] < 1) {
        [self showHint:BSLocalizedString(@"data.error")];
        
        check = NO;
    }
    
    if ([self.send_num intValue] > 10000) {
        [self showHint:BSLocalizedString(@"data.error")];
        
        check = NO;
    }
    
    return check;
}

#pragma mark - network
- (void)blockSend:(blockSendCallback)callback {
    
    
    
    NSString * url = PostBlockSend;
    NSString * privkey = [[BSDataBaseManager shareInstance] getUserInfo].privkey;
    if (!privkey) {
        return;
    }
    NSDictionary * parmae = @{
                              @"to":self.send_to,
                              @"number":self.send_num,
                              @"privkey":privkey
                              };
    
    
    [[BSNetWorking shareInstance] POST:url refresh:YES parameters:parmae success:^(id json) {
        if ([json[@"status"] intValue] == 1) {
         
            callback(nil);
        }else {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-101
                                             userInfo:json];
            callback(error);
        }
    } failure:^(NSError *error) {
        callback(error);
    }];
    
    
}


@end
