//
//  BSOrderTableViewContentCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderTableViewContentCell.h"
#import "BSOrderSalesReturnViewController.h"
#import "BSOrderListSuperViewController.h"
#import "BSChatViewController.h"

@interface BSOrderTableViewContentCell ()<BSAlertViewDelegate,BSOrderSalesReturnViewControllerDelegate>

@property (nonatomic) BSOrderModel * model;

@property (nonatomic) UIView * contentBgView;
@property (nonatomic) UIImageView * goodImgView;
@property (nonatomic) UILabel * goodIntroLab;
@property (nonatomic) UILabel * paymentLab;
@property (nonatomic) UILabel * priceLab;

/*  BSOrderForMeReleaseViewController专用 */
@property (nonatomic) UIButton * modifyBtn;

@end

@implementation BSOrderTableViewContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderTableViewContentCellID";
    BSOrderTableViewContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderTableViewContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.goodImgView];
    [self.contentBgView addSubview:self.goodIntroLab];
    [self.contentView addSubview:self.paymentLab];
    [self.contentView addSubview:self.priceLab];
    
    [self.contentView addSubview:self.modifyBtn];
    
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30.0f);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(90.0f);
    }];
    
    [self.goodImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentBgView);
        make.left.equalTo(self.contentBgView).offset(15.0f);
        make.width.height.mas_equalTo(60.0f);
    }];
    
    [self.goodIntroLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentBgView);
        make.left.mas_equalTo(self.goodImgView.mas_right).offset(15.0f);
        make.right.equalTo(self.contentBgView).offset(-15.0f);
    }];
    
    [self.paymentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-32.0f);
        make.right.mas_equalTo(self.priceLab.mas_left).offset(-5.0f);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.paymentLab);
        make.right.equalTo(self).offset(-20.0f);
    }];

    
    [self.modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.paymentLab);
        make.right.mas_equalTo(self.paymentLab.mas_left).offset(-20.0f);
    }];
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView {
    
    self.model = model;

    self.modifyBtn.hidden = YES;
    if (model.showModifyBtn ) {
        self.modifyBtn.hidden = NO;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:BSLocalizedString(@"modify.inventory")];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [self.modifyBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    
    //退币中 && 不是买家页面
    if ([model.ostate integerValue] == 5 && !model.isBuyer) {
        self.modifyBtn.hidden = NO;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:BSLocalizedString(@"decline")];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [self.modifyBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    
    if (![model isKindOfClass:[BSOrderModel class]]) {
        return;
    }
    
    [self.goodImgView bs_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    
    self.goodIntroLab.text = model.Description;
    
    [self.goodIntroLab BS_setLineSpacingForAll:12.0f];
    [self layoutIfNeeded];

    NSString * priceStr = model.money?model.money:model.price;
    
    self.priceLab.text = [NSString stringWithFormat:@"LAP:%@",priceStr];
    
}


- (void)modifyBtnClick {
    
    if ([self.model.ostate integerValue] == 5) {
        //拒绝申请
        self.model.isBuyer = NO;
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
        return;
    }

    BSAlertView * alert = [[BSAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"modify.inventory") delegate:self buttonTitles:BSLocalizedString(@"cancel"),BSLocalizedString(@"confirm"), nil];
    alert.alertViewStyle = BSAlertViewStyleTextInput;
    alert.numberTextField = YES;
    [alert show];

}

//跳转聊天
- (void)needPushMsgWithModel:(BSOrderModel *)model {
    BSConvenientOperationManager *manager = [BSConvenientOperationManager shareInstance];
    BSChatViewController * vc = [manager pushChatController:[self getCurrentViewController] phoneNumber:self.model.uid conversationType:EMConversationTypeChat];
    manager.toPhoto    = self.model.face;
    manager.toNickname = self.model.nickname;
    [vc sendMessagesWithImages:model.reImages title:model.reTitle content:model.reContent];
    
}

#pragma mark - BSAlertViewDelegate
- (void)BSAlertView:(BSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {

        NSString * number = [alertView textFieldAtIndex:0].text;
        
        if (number.length > 3) {
            [self showHint:[NSString stringWithFormat:BSLocalizedString(@"maximum.characters"),@"3"]];
            return;
        }
        
        
        [self changeInventoryWithNumber:number];
    }
}

- (void)changeInventoryWithNumber:(NSString *)number {
    NSDictionary * param = @{
                             @"gid":self.model.gid,
                             @"number":number
                             };
    [self showHUDInView:[self getCurrentViewController].view];
    [[BSNetWorking shareInstance] POST:ChangeInventory refresh:YES parameters:param success:^(id json) {
        
        if ([json[@"status"] intValue] == 1) {
            
            [BSAlertView showAlertWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"modify.is.successfully") sureButtonTitle:BSLocalizedString(@"ok")];
        }else {
            [self showHint:json[@"msg"]];
        }
        
        
        [self hideHUD];
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
}

- (UIView *)contentBgView {
    if (!_contentBgView) {
        _contentBgView = [UIView new];
        _contentBgView.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _contentBgView;
}

- (UIImageView *)goodImgView {
    if (!_goodImgView) {
        _goodImgView = [UIImageView new];
        _goodImgView.layer.borderWidth = 0.5;
        _goodImgView.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _goodImgView.contentMode = UIViewContentModeScaleAspectFill;
        _goodImgView.layer.masksToBounds = YES;
    }
    return _goodImgView;
}

- (UILabel *)goodIntroLab {
    if (!_goodIntroLab) {
        _goodIntroLab               = [[UILabel alloc] init];
        _goodIntroLab.textColor     = BSCOLOR_4B4B4B;
        _goodIntroLab.font          = [UIFont systemFontOfSize:12.0f];
        _goodIntroLab.numberOfLines = 2;
        _goodIntroLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodIntroLab;
}

- (UILabel *)paymentLab {
    if (!_paymentLab) {
        _paymentLab               = [[UILabel alloc] init];
        _paymentLab.textColor     = BSCOLOR_337FDD;
        _paymentLab.text = BSLocalizedString(@"payment");
        _paymentLab.font          = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _paymentLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab               = [[UILabel alloc] init];
        _priceLab.textColor     = BSCOLOR_337FDD;
        _priceLab.font          = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _priceLab;
}


- (UIButton *)modifyBtn {
    if (!_modifyBtn) {
        _modifyBtn = [UIButton new];
        [_modifyBtn addTarget:self action:@selector(modifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [_modifyBtn setTitle:@"modify inventory" forState:UIControlStateNormal];
        
        
        [_modifyBtn setTitleColor:BSCOLOR_4B4B4B forState:UIControlStateNormal];
        _modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _modifyBtn;
}
@end
