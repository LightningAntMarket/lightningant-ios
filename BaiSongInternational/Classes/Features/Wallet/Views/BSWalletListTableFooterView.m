//
//  BSWalletListTableFooterView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletListTableFooterView.h"
#import "BSWalletCreateViewController.h"
#import "BSBaseNavigationController.h"
#import "BSWalletImportViewController.h"
#import "BSBaseNavigationController.h"

#define Btn(t) t##Btn
#define BtnF 16.0f
#define BtnH 40.0f
#define BtnW 220.0f

@interface BSWalletListTableFooterView ()

@property (nonatomic) UIButton * Btn(left);
@property (nonatomic) UIButton * Btn(right);

@end


@implementation BSWalletListTableFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commomInit];
    }
    return self;
}


- (void)commomInit {
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
 
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(BtnW);
        make.height.mas_equalTo(BtnH);
        make.centerY.equalTo(self).multipliedBy(0.7);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.leftBtn);
        make.centerY.equalTo(self).multipliedBy(1.3);
    }];
    
}


- (void)leftBtnClick {
    BSWalletCreateViewController *vc = [BSWalletCreateViewController new];
    vc.viewType = BSWalletViewType_ShowBottomBtn | BSWalletViewType_BackBtnForDismiss;
    BSBaseNavigationController * logNav = [[BSBaseNavigationController alloc] initWithRootViewController:vc];
    [[self getCurrentViewController] presentViewController:logNav animated:YES completion:nil];
   
}

- (void)rightBtnClick {
    BSWalletImportViewController * vc = [[BSWalletImportViewController alloc]init];
    vc.viewType = BSWalletViewType_BackBtnForDismiss | BSWalletViewType_ShowBottomBtn;
    BSBaseNavigationController * logNav = [[BSBaseNavigationController alloc] initWithRootViewController:vc];
    [[self getCurrentViewController] presentViewController:logNav animated:YES completion:nil];
}





- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:BSLocalizedString(@"wallet.create.new.wallet") forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:BtnF];
        _leftBtn.layer.masksToBounds = YES;
        _leftBtn.backgroundColor = BSCOLOR_337FDD;
        _leftBtn.layer.cornerRadius = BtnH/2 ;
    }
    return _leftBtn;
}


- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:BSLocalizedString(@"wallet.import.wallet") forState:UIControlStateNormal];
        [_rightBtn setTitleColor:BSCOLOR_337FDD forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:BtnF];
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.backgroundColor = [UIColor whiteColor];
        _rightBtn.layer.cornerRadius = BtnH/2 ;
        _rightBtn.layer.borderColor = BSCOLOR_337FDD.CGColor;
        _rightBtn.layer.borderWidth = 1;
    }
    return _rightBtn;
}

@end
