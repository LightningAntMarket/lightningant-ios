//
//  BSOrderDetailTableViewFooterCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/19.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderDetailTableViewFooterCell.h"

#import "BSOrderSalesReturnViewController.h"

#import "BSOrderListSuperViewController.h"
#import "BSOrderDeliveryViewController.h"

#import "BSChatViewController.h"
#import "BSInputEvaluationViewController.h"
#import "BSGoodsDetailAllAppraiseViewController.h"
#import "BSLoginManager.h"


@interface BSOrderDetailTableViewFooterCell ()<BSOrderSalesReturnViewControllerDelegate>

@property (nonatomic) UIButton * leftBtn;
@property (nonatomic) UIButton * rightBtn;


@property (nonatomic) BSOrderModel * model;

@end

@implementation BSOrderDetailTableViewFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderDetailTableViewFooterCellID";
    BSOrderDetailTableViewFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderDetailTableViewFooterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupViews];
        
    }
    return self;
}


- (void)setupViews {
    
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).multipliedBy(0.5);
        make.width.mas_equalTo(160.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).multipliedBy(1.5);
        make.width.mas_equalTo(160.0f);
        make.height.mas_equalTo(40.0f);
    }];
    

}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView {
    
    self.model = model;
    
    switch (self.type) {
        case BSOrderViewType_OrderAuction:
        {
            
            NSInteger type = [model.ostate integerValue];
            
            if (type == 7 || type == 9 ||type == 10 ) {
                self.leftBtn.hidden = YES;
            }else {
                self.leftBtn.hidden = NO;
            }
            
            if (type == 9) {
                [self.rightBtn setTitle:BSLocalizedString(@"order.comments.to") forState:UIControlStateNormal];
            }else if (type == 10) {
                [self.rightBtn setTitle:BSLocalizedString(@"order.comments.to") forState:UIControlStateNormal];
            }
            
            if ([self.model.ostate integerValue] == 1) {
                //未发货、显示取消订单
                [self.leftBtn setTitle:BSLocalizedString(@"cancel.order") forState:UIControlStateNormal];
            }else {
                [self.leftBtn setTitle:BSLocalizedString(@"return.01") forState:UIControlStateNormal];
            }
            
        }
            break;
        case BSOrderViewType_OrderIssued:
        {
            
            self.leftBtn.hidden  = !([model.ostate intValue] == 5);
            
            if ([self.model.ostate integerValue] == 1) {
                //未发货、显示发货
                [self.rightBtn setTitle:BSLocalizedString(@"shipping") forState:UIControlStateNormal];
            }else {
                //发货后、显示确认订单
                [self.rightBtn setTitle:BSLocalizedString(@"order.down") forState:UIControlStateNormal];
            }
        }
            break;
            
        default:
            break;
    }
}



- (void)setType:(BSOrderViewType)type {
    _type = type;
    switch (type) {
        case BSOrderViewType_OrderAuction:
        {
            [self.rightBtn setTitle:BSLocalizedString(@"receipt") forState:UIControlStateNormal];
        }
            break;
            
        case BSOrderViewType_OrderIssued:
        {
            [self.leftBtn setTitle:BSLocalizedString(@"refund") forState:UIControlStateNormal];
            [self.rightBtn setTitle:BSLocalizedString(@"delivery") forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)leftBtnClick {
    switch (self.type) {
        case BSOrderViewType_OrderAuction:
        {
            
            if ([self.model.ostate integerValue] == 1) {
                //未发货、显示取消订单
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"whether.to.give.up.this.commodity") delegate:self cancelButtonTitle:BSLocalizedString(@"alert.yes") otherButtonTitles:BSLocalizedString(@"alert.no"), nil];
                alert.tag = BSOrderViewEventType_Cancel;
                [alert show];
                return;
            }
            
            //申请退币
            self.model.isBuyer = YES;
            BSOrderSalesReturnViewController * vc = [[BSOrderSalesReturnViewController alloc]initWithModel:self.model];
            vc.delegate = self;
            //BSOrderListSuperViewController 说明从我抢过的--竞拍订单而来
            if ([[self getCurrentViewController] isKindOfClass:[BSOrderListSuperViewController class]]) {
                BSOrderListSuperViewController * svc = (BSOrderListSuperViewController *)[self getCurrentViewController];
                [svc.nav pushViewController:vc animated:YES];
            }else {
                //反之正常跳转
                [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
            }
            
            
        }
            break;
            
        case BSOrderViewType_OrderIssued:
        {
            //同意退币
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"refund.tip.2") delegate:self cancelButtonTitle:BSLocalizedString(@"alert.yes") otherButtonTitles:BSLocalizedString(@"alert.no"), nil];
            
            alert.tag = BSOrderViewEventType_Refund;
            [alert show];

        }
            break;
            
        default:
            break;
    }
}

//跳转聊天
- (void)needPushMsgWithModel:(BSOrderModel *)model {
    BSConvenientOperationManager *manager = [BSConvenientOperationManager shareInstance];
    BSChatViewController * vc = [manager pushChatController:[self getCurrentViewController] phoneNumber:self.model.uid conversationType:EMConversationTypeChat];
    manager.toPhoto    = self.model.face;
    manager.toNickname = self.model.nickname;
    [vc sendMessagesWithImages:model.reImages title:model.reTitle content:model.reContent];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (!buttonIndex) {
            
            if (![[BSLoginManager shareInstance] blockKeyWithViewController:[self getCurrentViewController]]) {
                return;
            }
            
            switch (alertView.tag) {
                case BSOrderViewEventType_Receipt:
                {
                    [self showHUDInView:[self getCurrentViewController].view];
                    [self.model getTakeDeliveryBlc:^(NSError *err) {
                        [self hideHUD];
                        if(!err) {
                            [self showHint:BSLocalizedString(@"operation.is.successfully")];
                            [[self getCurrentViewController].navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }
                    break;
                case BSOrderViewEventType_Cancel:
                {
                    [self showHUDInView:[self getCurrentViewController].view];
                    [self.model GetGoodsCancel:^(NSError *err) {
                        
                        [self hideHUD];
                        if(!err) {
                            [self showHint:BSLocalizedString(@"operation.is.successfully")];
                            [[self getCurrentViewController].navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }
                    break;
                case BSOrderViewEventType_Refund:
                {
                    [self showHUDInView:[self getCurrentViewController].view];
                    [self.model getGoodsBack:^(NSError *err) {
                        
                        [self hideHUD];
                        if(!err) {
                            [self showHint:BSLocalizedString(@"operation.is.successfully")];
                            [[self getCurrentViewController].navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }
                    break;
                case BSOrderViewEventType_DeliverySeller:
                {
                    //卖方确认收货
                    [self showHUDInView:[self getCurrentViewController].view];
                    [self.model GetTakeDeliverySeller:^(NSError *err) {
                        [self hideHUD];
                        if(!err) {
                            [self showHint:BSLocalizedString(@"operation.is.successfully")];
                            [[self getCurrentViewController].navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }
    
}



- (void)rightBtnClick {
    switch (self.type) {
        case BSOrderViewType_OrderAuction:
        {
            //确认收货
            if (!self.model.isSended)  {
                //还没发货
                [self showHint:BSLocalizedString(@"to.be.delivered")];
            }else {
                
                NSInteger type = [self.model.ostate integerValue];
                
                if (type == 9) {
                    BSInputEvaluationViewController * vc = [[BSInputEvaluationViewController alloc]initWithOrderModel:self.model];
                    [self pushToOtherViewController:vc];
                }else if (type == 10) {
                    BSGoodsDetailAllAppraiseViewController * vc = [[BSGoodsDetailAllAppraiseViewController alloc] initWithUid:self.model.uid];
                    [self pushToOtherViewController:vc];
                }else {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"receipt") delegate:self cancelButtonTitle:BSLocalizedString(@"alert.yes") otherButtonTitles:BSLocalizedString(@"alert.no"), nil];
                    alert.tag = BSOrderViewEventType_Receipt;
                    [alert show];
                }
            }
        }
            break;
            
        case BSOrderViewType_OrderIssued:
        {
            
            
            if ([self.model.ostate integerValue] == 1) {
                //未发货、显示发货
                BSOrderDeliveryViewController * vc = [[BSOrderDeliveryViewController alloc]initWithModel:self.model];
                //BSOrderListSuperViewController 说明从我抢过的--竞拍订单而来
                [self pushToOtherViewController:vc];
            }else {
                //发货后、显示确认订单
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"confirm.order") delegate:self cancelButtonTitle:BSLocalizedString(@"alert.yes") otherButtonTitles:BSLocalizedString(@"alert.no"), nil];
                alert.tag = BSOrderViewEventType_DeliverySeller;
                [alert show];
                
            }
            
            
            
            
        }
            break;
            
        default:
            break;
    }
}



- (void)pushToOtherViewController:(UIViewController *)vc {
    if ([[self getCurrentViewController] isKindOfClass:[BSOrderListSuperViewController class]]) {
        BSOrderListSuperViewController * svc = (BSOrderListSuperViewController *)[self getCurrentViewController];
        [svc.nav pushViewController:vc animated:YES];
    }else {
        //反之正常跳转
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - network



- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.backgroundColor = [UIColor whiteColor];
        _leftBtn.layer.cornerRadius  = 20.0f;
        _leftBtn.layer.masksToBounds = YES;
        [_leftBtn setTitleColor:BSCOLOR_337FDD forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _leftBtn.layer.borderWidth = 0.5;
        _leftBtn.layer.borderColor = BSCOLOR_337FDD.CGColor;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.backgroundColor = BSCOLOR_337FDD;
        _rightBtn.layer.cornerRadius  = 20.0f;
        _rightBtn.layer.masksToBounds = YES;
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _rightBtn;
}



@end

