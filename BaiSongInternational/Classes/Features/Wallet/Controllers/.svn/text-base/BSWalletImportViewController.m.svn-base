//
//  BSWalletImportViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/9.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletImportViewController.h"
#import "BSUnderlineTextField.h"
#import "BSTradeBlockKeyImportViewController.h"
#import "BSWalletCreateViewController.h"
#import "EventIntervalButton.h"
#import "BSWalletCache.h"


#define TextFieldHeight 50.0f
#define TextFieldWidth 220.0f

@interface BSWalletImportViewController ()<BSUnderlineTextFieldDelegate>
@property (nonatomic) UILabel * titleLab1;

@property (nonatomic) EventIntervalButton * importKeyStoreBtn;
@property (nonatomic) EventIntervalButton * importPrivateKeyBtn;
@property (nonatomic) UILabel * tipLab;
@property (nonatomic) UIButton * bottomBtn;
@property (nonatomic) UIView * bottomLine;
@end

@implementation BSWalletImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.viewType  & BSWalletViewType_HideBackBtn) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    }
}

#pragma mark - touch event
- (void)leftItemClick {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//导入keyStore
- (void)importKeyStoreBtnClick {
    BSTradeBlockKeyImportViewController * vc = [BSTradeBlockKeyImportViewController new];
    vc.type = BSWalletImportType_KeyStore;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//导入privateKey
- (void)importPrivateKeyBtnClick {
    BSTradeBlockKeyImportViewController * vc = [BSTradeBlockKeyImportViewController new];
    vc.type = BSWalletImportType_PrivateKey;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)bottomBtnClick {
    BSWalletCreateViewController * vc = [BSWalletCreateViewController new];
    vc.viewType = BSWalletViewType_BackBtnForPop;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - private method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLab1];
    [self.view addSubview:self.importKeyStoreBtn];
    [self.view addSubview:self.importPrivateKeyBtn];
    [self.view addSubview:self.tipLab];
    [self.view addSubview:self.bottomBtn];
    [self.view addSubview:self.bottomLine];
    
    [self layoutCustomViews];
    

    if (self.viewType & BSWalletViewType_BackBtnForDismiss) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"publish_back_button"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"";
    
}


- (void)layoutCustomViews {
    
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(25.0f);
        make.left.equalTo(self.view).offset(20.0f);
    }];

    
    [self.importKeyStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-50.0f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(TextFieldWidth);
        make.height.mas_equalTo(TextFieldHeight);
    }];
    
    [self.importPrivateKeyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.importKeyStoreBtn.mas_bottom).offset(20.0f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(TextFieldWidth);
        make.height.mas_equalTo(TextFieldHeight);
    }];
    
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.importPrivateKeyBtn.mas_bottom).offset(30.0f);
        make.centerX.equalTo(self.view);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20.0f);
        make.centerX.equalTo(self.view);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomBtn.mas_bottom).offset(0.1f);
        make.centerX.width.equalTo(self.bottomBtn);
        make.height.mas_equalTo(0.5f);
    }];
}


#pragma mark- setter && getter

- (UILabel *)titleLab1 {
    if (!_titleLab1) {
        _titleLab1 = [UILabel new];
        _titleLab1.textColor = BSCOLOR_000;
        _titleLab1.font = [UIFont boldSystemFontOfSize:21.0f];
        _titleLab1.text = BSLocalizedString(@"insert.wallet");
    }
    return _titleLab1;
}


- (EventIntervalButton *)importKeyStoreBtn {
    if (!_importKeyStoreBtn) {
        _importKeyStoreBtn = [EventIntervalButton new];
        [_importKeyStoreBtn addTarget:self action:@selector(importKeyStoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _importKeyStoreBtn.backgroundColor = BSCOLOR_337FDD;
        _importKeyStoreBtn.layer.cornerRadius  = TextFieldHeight/2;
        _importKeyStoreBtn.layer.masksToBounds = YES;
        [_importKeyStoreBtn setTitle:BSLocalizedString(@"wallet.input.Keystore") forState:UIControlStateNormal];
        [_importKeyStoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _importKeyStoreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _importKeyStoreBtn.layer.borderWidth = 0.5;
        _importKeyStoreBtn.layer.borderColor = [UIColor colorWithHexString:@"a0a0a0" alpha:0.4].CGColor;
        _importKeyStoreBtn.eventInterval = 3;
    }
    return _importKeyStoreBtn;
}

- (EventIntervalButton *)importPrivateKeyBtn {
    if (!_importPrivateKeyBtn) {
        _importPrivateKeyBtn = [EventIntervalButton new];
        [_importPrivateKeyBtn addTarget:self action:@selector(importPrivateKeyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _importPrivateKeyBtn.backgroundColor = [UIColor whiteColor];
        _importPrivateKeyBtn.layer.cornerRadius  = TextFieldHeight/2;
        _importPrivateKeyBtn.layer.masksToBounds = YES;
        [_importPrivateKeyBtn setTitle:BSLocalizedString(@"wallet.input.private.key") forState:UIControlStateNormal];
        [_importPrivateKeyBtn setTitleColor:BSCOLOR_337FDD forState:UIControlStateNormal];
        _importPrivateKeyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _importPrivateKeyBtn.layer.borderWidth = 0.5;
        _importPrivateKeyBtn.layer.borderColor = BSCOLOR_337FDD.CGColor;
        _importPrivateKeyBtn.eventInterval = 3;
    }
    return _importPrivateKeyBtn;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.textColor = BSCOLOR_888;
        _tipLab.font = [UIFont boldSystemFontOfSize:12.0f];
        _tipLab.text = BSLocalizedString(@"wallet.tip.6");
    }
    return _tipLab;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton new];
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn setTitle:BSLocalizedString(@"wallet.create.a.wallet") forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:BSCOLOR_4B4B4B forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _bottomBtn.hidden = YES;
        
    }
    return _bottomBtn;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = BSCOLOR_4B4B4B;
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}

- (void)setViewType:(BSWalletViewStyle)viewType {
    _viewType = viewType;
    if (viewType & BSWalletViewType_ShowBottomBtn) {
        self.bottomBtn.hidden = NO;
        self.bottomLine.hidden = NO;
    }else {
        self.bottomBtn.hidden = YES;
        self.bottomLine.hidden = YES;
    }
}
@end
