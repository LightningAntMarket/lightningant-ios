//
//  BSTradeBlockKeyBackUpViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2017/10/25.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeBlockKeyBackUpViewController.h"

#define TextFieldHeight 50.0f
#define TextFieldWidth 220.0f

static NSString * GetBlockAddress = @"Android/User/getBlockAddress";

@interface BSTradeBlockKeyBackUpViewController ()<UIAlertViewDelegate>
@property (nonatomic) UILabel  * titleLab1;
@property (nonatomic) UILabel  * titleLab2;
@property (nonatomic) UIView   * line;
@property (nonatomic) UIButton * backUpBtn;
@property (nonatomic) UILabel  * tipLab;
@end

@implementation BSTradeBlockKeyBackUpViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    if (self.cantGoBack) {
        //不允许返回
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    }
    
    BSUser * user = [[BSDataBaseManager shareInstance] getUserInfo];
    
    if (user.privkey.length == 0) {
        //Data层不存在私钥、尝试拉取
        [self loadData];
    }else {
        //存在私钥、直接展示
        self.titleLab2.text = user.privkey;
        self.backUpBtn.userInteractionEnabled = YES;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.cantGoBack) {
        //不允许返回
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    }
    
}



//拷贝
- (void)backUpBtnClick {
    //copy
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    pBoard.string = self.titleLab2.text;
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"wallet.tip.4") delegate:self cancelButtonTitle:BSLocalizedString(@"ok") otherButtonTitles:nil, nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - private method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLab1];
    [self.view addSubview:self.titleLab2];
    [self.view addSubview:self.line];
    [self.view addSubview:self.backUpBtn];
    [self.view addSubview:self.tipLab];
 
    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(75.0f);
        make.left.equalTo(self.view).offset(20.0f);
    }];
    
    [self.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab1.mas_bottom).offset(34.0f);
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab2.mas_bottom).offset(20.0f);
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    [self.backUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(35.0f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(TextFieldWidth);
        make.height.mas_equalTo(TextFieldHeight);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20.0f);
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
    }];
    

}

- (void)loadData {
    NSString * url = GetBlockAddress;
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] intValue] == 1) {
            BSUser *user = [[BSUser alloc] initContentWithDic:[json objectForKey:@"data"]];
            self.titleLab2.text = user.privkey;
            [[BSDataBaseManager shareInstance] insertUserInfoToDB:user];
            
            
            self.backUpBtn.userInteractionEnabled = YES;
        }else {
            self.titleLab2.text = @"NONE";
            
            [BSAlertView showSystemAlertViewTitle:BSLocalizedString(@"tips") message:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
}



#pragma mark- setter && getter

- (UILabel *)titleLab1 {
    if (!_titleLab1) {
        _titleLab1 = [UILabel new];
        _titleLab1.textColor = BSCOLOR_000;
        _titleLab1.font = [UIFont boldSystemFontOfSize:21.0f];
        _titleLab1.text = BSLocalizedString(@"create.wallet");
    }
    return _titleLab1;
}

- (UILabel *)titleLab2 {
    if (!_titleLab2) {
        _titleLab2 = [UILabel new];
        _titleLab2.textColor = BSCOLOR_4B4B4B;
        _titleLab2.font = [UIFont systemFontOfSize:16.0f];
        _titleLab2.numberOfLines = 0 ;
    }
    return _titleLab2;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

- (UIButton *)backUpBtn {
    if (!_backUpBtn) {
        _backUpBtn = [UIButton new];
        [_backUpBtn addTarget:self action:@selector(backUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _backUpBtn.backgroundColor = BSCOLOR_337FDD;
        _backUpBtn.layer.cornerRadius  = TextFieldHeight/2;
        _backUpBtn.layer.masksToBounds = YES;
        [_backUpBtn setTitle:BSLocalizedString(@"copy") forState:UIControlStateNormal];
        [_backUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backUpBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _backUpBtn.layer.borderWidth = 0.5;
        _backUpBtn.layer.borderColor = [UIColor colorWithHexString:@"a0a0a0" alpha:0.4].CGColor;
        _backUpBtn.userInteractionEnabled = NO;
    }
    return _backUpBtn;
}


- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.textColor = BSCOLOR_4B4B4B;
        _tipLab.font = [UIFont systemFontOfSize:16.0f];
        _tipLab.text = BSLocalizedString(@"key.tip.03");
        _tipLab.numberOfLines = 0 ;
        _tipLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLab;
}



@end
