//
//  BSTaskModel.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BaseModel.h"

@interface BSTsakCompleteUserModel : BaseModel

@property (nonatomic, copy) NSString * face;//头像
@property (nonatomic, copy) NSString * uid;//用户id
@end

@interface BSTsakExeStepModel : BaseModel

@property (nonatomic, copy) NSString * text;//步骤说明
@property (nonatomic, copy) NSString * img;//步骤图片
@end

@interface BSTaskModel : BaseModel

/**
 列表页面用
 */
@property (nonatomic, copy) NSString * accept_num;//接单人数
@property (nonatomic, copy) NSString * describes;//任务描述
@property (nonatomic, copy) NSString * complete_num;//完成任务
@property (nonatomic, copy) NSString * face;//发布人头像
@property (nonatomic, copy) NSString * Id;//任务ID
@property (nonatomic, copy) NSString * nickname;//发布人昵称
@property (nonatomic, copy) NSString * pub_id;//发布人ID
@property (nonatomic, copy) NSString * total_num;//任务总数
@property (nonatomic, copy) NSString * wages;//单次酬金


/**
 详情页面用
 */
@property (nonatomic, copy) NSString * check_task;//任务状态 10已接单20已提交30已完成40未接单
@property (nonatomic, copy) NSString * end_time;//结束时间
@property (nonatomic, copy) NSString * start_time;//开始时间
@property (nonatomic, copy) NSString * url;//链接
@property (nonatomic) NSMutableArray * check_img;//审核图数组
@property (nonatomic) NSMutableArray<BSTsakExeStepModel *> * exe_step;//步骤数组
@property (nonatomic) NSMutableArray<BSTsakCompleteUserModel *> * complete_user;//完成用户数组


- (void)configModelWithDetailDic:(NSDictionary *)dic;
@end



/**
 发布者的订单model
 */
@interface BSTaskOrderModelForSend : BaseModel

@property (nonatomic, copy) NSString * Id;//任务ID
@property (nonatomic, copy) NSString * user_id;//接单人id
@property (nonatomic, copy) NSString * task_id;//任务id
@property (nonatomic, copy) NSString * pub_id;//发布人id
@property (nonatomic, copy) NSString * sub_time;//提交审核时间
@property (nonatomic, copy) NSString * describe;//提交描述
@property (nonatomic, copy) NSArray * check_content;//提交的图片
@property (nonatomic, copy) NSString * face;//接单人头像
@property (nonatomic, copy) NSString * nickname;//接单人昵称

@property (nonatomic, copy) NSString * task_describes;//任务描述
@property (nonatomic, copy) NSString * task_check_img;//任务审核图

@end


