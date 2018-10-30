//
//  BSTaskPublishDataSource.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSUploadImageManager.h"


@class BSTaskPublishGuideModel;

/**
 任务发布结数据源
 */
@interface BSTaskPublishDataSource : NSObject

/**
 任务描述
 */
@property (nonatomic, copy) NSString * desc;

/**
 价格
 */
@property (nonatomic, copy) NSString * price;

/**
 奖励份数
 */
@property (nonatomic, copy) NSString * prizeNum;

/**
 链接
 */
@property (nonatomic, copy) NSString * Link;

/**
 截止时间
 */
@property (nonatomic, copy) NSString * overTime;


@property (nonatomic, copy) NSDate *overDate;
/**
 任务说明数组
 */
@property (nonatomic) NSMutableArray<BSTaskPublishGuideModel *> * guideArr;

/**
 审核标准图例
 */
@property (nonatomic) NSMutableArray * exampleArr;
@end



/**
 任务说明结构体
 */
@interface BSTaskPublishGuideModel : NSObject
@property (nonatomic) BSUploadImageDataSource * imgDataSource;
//在步骤编辑页面的img.如果和imgDataSource不同则需要上传
@property (nonatomic) UIImage * cacheImg;
@property (nonatomic,copy) NSString * desc;

@end




typedef void (^BSTaskPublishHelperSuccessBlock)(void);


/**
 error.info.msg
 
 100 - 内容字数超限
 101 - 图片上传失败
 103 - 发布类型有问题
 111 - 链接图片上传失败
 */
typedef void (^BSTaskPublishHelperFailureBlock)(NSError *error);

/**
 任务发布的辅助器
 */
@interface BSTaskPublishHelper : NSObject


/**
 数据源
 */
@property (nonatomic) BSTaskPublishDataSource * dataSource;






////////////////////限制条件//////////////////////////

/**
 任务描述
 */
@property (nonatomic) NSInteger descMinCount;
@property (nonatomic) NSInteger descMaxCount;

/**
 价格
 */
@property (nonatomic) CGFloat priceMaxNum;

/**
 奖励份数
 */
@property (nonatomic) CGFloat prizeMaxNum;

/**
 结束时间
 */
@property (nonatomic) NSTimeInterval minOverTime;
@property (nonatomic) NSTimeInterval maxOverTime;
/**
 操作流程
 */
@property (nonatomic) NSInteger guideArrMaxCount;
@property (nonatomic) NSInteger guideDescMaxCount;
@property (nonatomic) NSInteger guideDescMinCount;



/**
 快捷链接
 */
@property (nonatomic) NSInteger linkMaxCount;


/**
 提交按钮是否点亮
 */
@property (nonatomic, getter=isPayBtnCanClick) BOOL payBtnCanClick;


/**
 检查提交按钮是否可以点亮
 返回payBtnCanClick是否被改变了
 */
- (BOOL)checkPayBtnStatus;

/**
 检查任务流程页面数据源

 @param arr 数据源
 @return 是否合规
 */
- (BOOL)checkGuideWithArr:(NSMutableArray *)arr;



/**
 生成一个带有配置的helper

 */
+ (BSTaskPublishHelper *)helper;

/**
 最后检查数据源、定位错误并返回错误提示
 */
- (NSString *)checkDataSource;


/**
 总计支付金额

 */
- (CGFloat)amountPaymentNumber;


/**
 将暂存的图片上传

 @param guideArr 暂存的图片
 @param completionHandler 回调为数组则成功、nil则失败
 */
- (void )upLoadImgWithGuideArr:(NSMutableArray<BSTaskPublishGuideModel *> *)guideArr completionHandler:(void (^)(NSMutableArray<BSTaskPublishGuideModel *> * arr)) completionHandler;


/**
 发布
 */
- (void)publishDataWithSuccess:(BSTaskPublishHelperSuccessBlock)success failure:(BSTaskPublishHelperFailureBlock)failure;
@end
