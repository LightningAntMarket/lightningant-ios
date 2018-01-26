//
//  BSOrderModel.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BaseModel.h"

/**
 *    个人中心--订单列表
 *    我抢过的--一口价、竞拍
 *    我送过的--一口价、竞拍
 **/

@interface BSOrderModel : BaseModel


typedef void(^TakeDeliveryBlc)(NSError * err);
typedef void(^GetGoodsBackBlc)(NSError * err);
typedef void(^GetGoodsCancelBlc)(NSError * err);
typedef void(^GetTakeDeliverySellerBlc)(NSError * err);

/*  基础---订单列表   */
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * bided;
@property (nonatomic,copy) NSString * cover;
@property (nonatomic,copy) NSString * Description;
@property (nonatomic,copy) NSString * face;
@property (nonatomic,copy) NSString * gid;
@property (nonatomic,copy) NSString * oid;
@property (nonatomic,copy) NSString * is_get;
//money 和 price哪个有值用哪个
@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * nickname;
@property (nonatomic,copy) NSString * ouid;
@property (nonatomic,copy) NSString * time;
@property (nonatomic,copy) NSString * uid;
//1、抢到了。3、发货了。5、申请退币。7、交易关闭。9、交易成功/未评价 10、交易成功/已评价 20、自己发货后的虚拟状态
@property (nonatomic,copy) NSString * ostate;

/*  自有属性---订单状态 */
@property (nonatomic,copy) NSString * orderStatus;
@property (nonatomic,copy) NSString * orderStatusImg;


/* 追加---订单详情 */
@property (nonatomic,copy) NSString * city;
//完成订单
@property (nonatomic,copy) NSString * confirmtime;
@property (nonatomic,copy) NSString * consignee;

@property (nonatomic,copy) NSString * returntime;

//快递单号
@property (nonatomic,copy) NSString * express;
@property (nonatomic,copy) NSString * express_number;
@property (nonatomic,copy) NSString * express_company;

@property (nonatomic,copy) NSString * mobile;
@property (nonatomic,copy) NSString * sendtime;
@property (nonatomic,copy) NSString * senduid;

//YES==>买家  NO==>卖家
@property (nonatomic) BOOL isBuyer;



//快递单号 express
@property (nonatomic,copy) NSString * fitAddress;

@property (nonatomic) BOOL isSended;

- (BOOL)checkSendGoodInfo;

/*  发货页面、更新model*/
- (void)configSendDataWithDic:(NSDictionary *)dic;


- (void)sendOver;


//3竞拍 2一口价
@property (nonatomic,copy) NSString * modetype;

//服务我送过的--进行中--控制改库存按钮
//赋值后根据具体数据行一步判断
@property (nonatomic) BOOL showModifyBtn;






//申请/拒绝退币
@property (nonatomic) NSMutableArray * reImages;
@property (nonatomic,copy) NSString * reTitle;
@property (nonatomic,copy) NSString * reContent;







//更改状态之后、可以手动调用更新显示内容
- (void)configOrderStatus;




//确认收货
- (void)getTakeDeliveryBlc:(TakeDeliveryBlc)block;
//同意退币
- (void)getGoodsBack:(GetGoodsBackBlc)block;
//取消订单
- (void)GetGoodsCancel:(GetGoodsCancelBlc)block;
//确认收货---卖方
- (void)GetTakeDeliverySeller:(GetTakeDeliverySellerBlc)block;


@end

