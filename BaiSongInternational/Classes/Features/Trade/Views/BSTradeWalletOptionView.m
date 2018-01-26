//
//  BSTradeWalletOptionView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeWalletOptionView.h"


#import "BSTradePayinViewController.h"
#import "BSTradePayoutViewController.h"




@interface BSTradeWalletOptionView ()
@property (nonatomic) UIButton * payinBtn;
@property (nonatomic) UIButton * payoutBtn;
@end

@implementation BSTradeWalletOptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {

    
    

    
    [self addSubview:self.payinBtn];
    [self addSubview:self.payoutBtn];
    
    
  
    [self.payinBtn setTitle:BSLocalizedString(@"withdraw.LAP") forState:UIControlStateNormal];
    [self.payoutBtn setTitle:BSLocalizedString(@"trade.receiving") forState:UIControlStateNormal];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    
    [self.payinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.mas_equalTo(self.mas_centerX).offset(-10.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    [self.payoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(self.mas_centerX).offset(10.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    
}

- (void)payinBtnClick {
    
    BSTradePayoutViewController * vc = [BSTradePayoutViewController new];
    vc.model = self.model;
    [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
    
}

- (void)payoutBtnClick {
    [[self getCurrentViewController].navigationController pushViewController:[BSTradePayinViewController new] animated:YES];
}




- (UIButton *)payinBtn {
    if (!_payinBtn) {
        _payinBtn = [UIButton new];
        [_payinBtn addTarget:self action:@selector(payinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _payinBtn.backgroundColor = BSCOLOR_337FDD;
        _payinBtn.layer.cornerRadius  = 20.0f;
        _payinBtn.layer.masksToBounds = YES;
        _payinBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _payinBtn.layer.borderWidth = 0.5;
        _payinBtn.layer.borderColor = BSCOLOR_337FDD.CGColor;
        [_payinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _payinBtn;
}

- (UIButton *)payoutBtn {
    if (!_payoutBtn) {
        _payoutBtn = [UIButton new];
        [_payoutBtn addTarget:self action:@selector(payoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _payoutBtn.backgroundColor = BSCOLOR_337FDD;
        _payoutBtn.layer.cornerRadius  = 20.0f;
        _payoutBtn.layer.masksToBounds = YES;
        [_payoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payoutBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _payoutBtn;
}

@end
