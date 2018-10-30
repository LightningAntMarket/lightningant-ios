//
//  BSTaskPublishDataSource.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishDataSource.h"

#import "BSAliyunOSSManager.h"
#import "BSWalletCache.h"
#import "BSError.h"
#import "NSArray+JSON.h"



NSDictionary * TaskPublishHelperReductionParame(BSTaskPublishDataSource *dataSource) {
    
    long time=(long)[dataSource.overDate timeIntervalSince1970];
    NSString * overTime = [[NSNumber numberWithLong:time] stringValue];
    NSMutableArray * exe_step_arr = [NSMutableArray new];

    for (BSTaskPublishGuideModel * model in dataSource.guideArr) {
        NSDictionary * json;
        if (model.imgDataSource.imageOSSAddress.length) {
            json = @{@"img":model.imgDataSource.imageOSSAddress,@"text":model.desc};

        }else {
            json = @{@"text":model.desc};
        }
        [exe_step_arr addObject:json];
    }
    
    NSString * exe_step_arr_json = [exe_step_arr toJSONString];
    
    NSString * privkey = [[BSWalletCache shareInstance] walletData].privateKey;
    NSDictionary * dic  = @{
                            @"describes":dataSource.desc,
                            @"wages":dataSource.price,
                            @"total_num":dataSource.prizeNum,
                            @"end_time":overTime,
                            @"exe_step":exe_step_arr_json,
                            @"privkey":privkey
                            };
    NSMutableDictionary * parame = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (dataSource.exampleArr.count) {
        NSString * exampleImg = [dataSource.exampleArr componentsJoinedByString:@","];
        [parame setObject:exampleImg forKey:@"check_img"];
    }
    if (dataSource.Link.length) {
        NSString * link_url = [dataSource.Link lowercaseString];
        if (![link_url containsString:@"http"]) {
            link_url = [@"http://" stringByAppendingString:link_url];
        }
        [parame setObject:link_url forKey:@"link_url"];
    }
    
    return parame;
}

@implementation BSTaskPublishDataSource
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.guideArr = [NSMutableArray new];
        self.exampleArr = [NSMutableArray new];
    }
    return self;
}
@end

@implementation BSTaskPublishGuideModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imgDataSource =  [BSUploadImageDataSource new];
    }
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    
    BSTaskPublishGuideModel * model = [[BSTaskPublishGuideModel allocWithZone:zone] init];
    
    model.imgDataSource = [self.imgDataSource copy];//self是被copy的对象
    
    model.desc = [self.desc copy];
    
    return model;
    
}

@end


@implementation BSTaskPublishHelper

+ (BSTaskPublishHelper *)helper {
    BSTaskPublishHelper * helper = [BSTaskPublishHelper new];
    helper.dataSource = [BSTaskPublishDataSource new];
    
    helper.descMinCount = 10;
    helper.descMaxCount = 100;
    helper.priceMaxNum = 999999.99;
    helper.prizeMaxNum = 999;
    
    helper.minOverTime = 60*60*24;
    helper.maxOverTime = 60*60*24*30;
    
    helper.guideArrMaxCount = 20;
    helper.guideDescMaxCount = 100;
    helper.guideDescMinCount = 1;
    
    helper.linkMaxCount = 100;
    
    helper.payBtnCanClick = NO;
    
    
    return helper;
}

- (BOOL)checkPayBtnStatus {
    BOOL b = self.isPayBtnCanClick;
    

    self.payBtnCanClick = [self checkPayBtnStatusWithDataSource];
    
    
    if (b != self.payBtnCanClick) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)checkPayBtnStatusWithDataSource {
//    if ([self.dataSource.price floatValue] < 1) {
//        return NO;
//    }
    
    if ([self.dataSource.prizeNum floatValue] <= 0) {
        return NO;
    }
    
    if (self.dataSource.desc.length == 0) {
        return NO;
    }
    
    if (self.dataSource.overTime.length == 0) {
        return NO;
    }
    
    if (self.dataSource.guideArr.count == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)checkGuideWithArr:(NSMutableArray *)arr {
    for (BSTaskPublishGuideModel * model in arr) {
        if (model.desc.length < self.guideDescMinCount || model.desc.length > self.guideDescMaxCount) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)checkDataSource {
    NSString * errStr;
    


    
    NSTimeInterval  time = [[NSDate date] timeIntervalSinceDate:self.dataSource.overDate];
    if (-time < self.minOverTime || -time > self.maxOverTime) {
        errStr = [NSString stringWithFormat:@"%@", BSLocalizedString(@"最大30天、最小1天")];
    }
    
    
    
    
    return errStr;
    
}



- (CGFloat)amountPaymentNumber {
    CGFloat price = [self.dataSource.price floatValue];
    CGFloat prize = [self.dataSource.prizeNum floatValue];
    
    return prize*price;
}

- (void)upLoadImgWithGuideArr:(NSMutableArray<BSTaskPublishGuideModel *> *)guideArr completionHandler:(void (^)(NSMutableArray<BSTaskPublishGuideModel *> *))completionHandler {
    
    dispatch_queue_t q = dispatch_queue_create("tsakguide.uploadimgs.queue", DISPATCH_QUEUE_CONCURRENT);
    
    //图片地址
    NSMutableArray * addressArr = [NSMutableArray new];
    BSAliyunOSSManager *manager = [BSAliyunOSSManager sharedInstance];
    
    dispatch_async(q, ^{
        for (int i = 0; i < guideArr.count; i++) {
            BSTaskPublishGuideModel * model = guideArr[i];
            
            if (![model.cacheImg isEqual:model.imgDataSource.image] && model.cacheImg) {
                //不同则需要上传
                
                NSData *imageData = bs_transformImgToData(model.cacheImg);
            
                NSString * address = [manager syncUploadImageData:imageData error:nil];
                if (!address) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionHandler(nil);
                    });
                }else {
                    [addressArr addObject:address];
                }
                

            }else {
                
                //相同则只调整顺序
                [addressArr addObject:model.imgDataSource.imageOSSAddress?:@""];
            }
        }
        
        NSMutableArray<BSTaskPublishGuideModel *> * arr = [NSMutableArray new];
        for (int i = 0; i < guideArr.count; i++) {
            BSTaskPublishGuideModel * model = [BSTaskPublishGuideModel new];
            model.cacheImg = guideArr[i].cacheImg;
            model.imgDataSource.image = guideArr[i].cacheImg;
            model.imgDataSource.imageOSSAddress = addressArr[i];
            model.desc = guideArr[i].desc;
            [arr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(arr);
        });
    });

}


- (void)publishDataWithSuccess:(BSTaskPublishHelperSuccessBlock)success failure:(BSTaskPublishHelperFailureBlock)failure {
    
    NSDictionary * parame = TaskPublishHelperReductionParame(self.dataSource);
    
    
    [[BSNetWorking shareInstance] POST:POSTAddTask refresh:YES parameters:parame success:^(id json) {
        if ([json[@"status"] integerValue] == 1) {
            success();
        }else {
            failure(KTErrorWithMsg(json[@"msg"], 0));
        }
    } failure:^(NSError *error) {
        failure(nil);
    }];
}

@end
