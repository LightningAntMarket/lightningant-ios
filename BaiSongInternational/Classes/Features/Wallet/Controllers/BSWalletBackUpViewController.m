//
//  BSWalletBackUpViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/9.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletBackUpViewController.h"
#import "UIViewController+Snapshot.h"

#define TextFieldHeight 50.0f
#define TextFieldWidth 220.0f

static NSString * PostKeystore;

@interface BSWalletBackUpViewController ()
//keystore
@property (nonatomic) UILabel  * titleLab1;
@property (nonatomic) UILabel  * titleLab2;
@property (nonatomic) UITextView  * textView;
@property (nonatomic) UIView   * line;
@property (nonatomic) UIButton * backUpBtn;

@property (nonatomic) UILabel  * privkTitleLab1;
@property (nonatomic) UILabel  * privkTitleLab2;
@property (nonatomic) UIView   * privkLine;
@property (nonatomic) UIButton * privkBackUpBtn;
//
//@property (nonatomic) UILabel  * waringLab;
//@property (nonatomic) UILabel  * tipLab;
@property (nonatomic) BSWalletData * walletData;

//替换左返回键
@property (nonatomic) UIBarButtonItem      * backBtnItem;

@property (nonatomic) UIScrollView * scrollView;
@property (nonatomic) UIView * bgView;
@end

@implementation BSWalletBackUpViewController

#pragma mark - touch event
- (void)leftItemClick {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
}


- (instancetype)initWithWalletData:(BSWalletData *)walletData
{
    self = [super init];
    if (self) {
        self.walletData = walletData;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//拷贝
- (void)backUpBtnClick {
    //copy
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    pBoard.string = self.titleLab2.text;
    
    
    
    __weak typeof(self) weak_self = self;
    [self snapshotCompletion:^(UIImage *image) {
        __strong typeof(weak_self) strong_self = weak_self;
        if (image) {
            [strong_self showHint:BSLocalizedString(@"copy.is.successfully")];
        }
    }];
}


//拷贝
- (void)privkBackUpBtnClick {
    //copy
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    pBoard.string = self.privkTitleLab2.text;

    __weak typeof(self) weak_self = self;
    [self snapshotCompletion:^(UIImage *image) {
        __strong typeof(weak_self) strong_self = weak_self;
        if (image) {
            [strong_self showHint:BSLocalizedString(@"copy.is.successfully")];
        }
    }];
}


- (void)loadData {
    NSString * url = PostKeystore;
    [self showHUDInView:self.view];
    
    NSDictionary * parameters = @{@"privkey":self.walletData.privateKey};
    
    [[BSNetWorking shareInstance] POST:url refresh:YES parameters:parameters success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] intValue] == 1) {
            NSError *parseError = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json[@"keystore"] options:NSJSONWritingPrettyPrinted error:&parseError];
            self.titleLab2.text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            self.privkTitleLab2.text = self.walletData.privateKey;
        }
        
        
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
    

}




#pragma mark - private method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLab1.text = BSLocalizedString(@"wallet.export.keystore");
    self.privkTitleLab1.text = BSLocalizedString(@"wallet.export.private.key");

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab1];
    [self.bgView addSubview:self.titleLab2];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.backUpBtn];
    
    [self.bgView addSubview:self.privkTitleLab1];
    [self.bgView addSubview:self.privkTitleLab2];
    [self.bgView addSubview:self.privkLine];
    [self.bgView addSubview:self.privkBackUpBtn];

    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
    }];
    
    
    [self.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab1.mas_bottom).offset(34.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
        make.right.equalTo(self.bgView).offset(-20.0f);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab2.mas_bottom).offset(20.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
        make.right.equalTo(self.bgView).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    [self.backUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line).offset(35.0f);
        make.centerX.equalTo(self.bgView);
        make.width.mas_equalTo(TextFieldWidth);
        make.height.mas_equalTo(TextFieldHeight);
    }];
    
    
    [self.privkTitleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backUpBtn.mas_bottom).offset(30.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
    }];
    
    [self.privkTitleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.privkTitleLab1.mas_bottom).offset(34.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
        make.right.equalTo(self.bgView).offset(-20.0f);
    }];
    
    [self.privkLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.privkTitleLab2.mas_bottom).offset(20.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
        make.right.equalTo(self.bgView).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    
    [self.privkBackUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.privkLine).offset(35.0f);
        make.centerX.equalTo(self.bgView);
        make.width.mas_equalTo(TextFieldWidth);
        make.height.mas_equalTo(TextFieldHeight);
    }];

}




#pragma mark- setter && getter

- (UILabel *)titleLab1 {
    if (!_titleLab1) {
        _titleLab1 = [UILabel new];
        _titleLab1.textColor = BSCOLOR_000;
        _titleLab1.font = [UIFont boldSystemFontOfSize:21.0f];
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



- (UILabel *)privkTitleLab1 {
    if (!_privkTitleLab1) {
        _privkTitleLab1 = [UILabel new];
        _privkTitleLab1.textColor = BSCOLOR_000;
        _privkTitleLab1.font = [UIFont boldSystemFontOfSize:21.0f];
    }
    return _privkTitleLab1;
}

- (UILabel *)privkTitleLab2 {
    if (!_privkTitleLab2) {
        _privkTitleLab2 = [UILabel new];
        _privkTitleLab2.textColor = BSCOLOR_4B4B4B;
        _privkTitleLab2.font = [UIFont systemFontOfSize:16.0f];
        _privkTitleLab2.numberOfLines = 0 ;
    }
    return _privkTitleLab2;
}

- (UIView *)privkLine {
    if (!_privkLine) {
        _privkLine = [UIView new];
        _privkLine.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _privkLine;
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
    }
    return _backUpBtn;
}


- (UIButton *)privkBackUpBtn {
    if (!_privkBackUpBtn) {
        _privkBackUpBtn = [UIButton new];
        [_privkBackUpBtn addTarget:self action:@selector(privkBackUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _privkBackUpBtn.backgroundColor = BSCOLOR_337FDD;
        _privkBackUpBtn.layer.cornerRadius  = TextFieldHeight/2;
        _privkBackUpBtn.layer.masksToBounds = YES;
        [_privkBackUpBtn setTitle:BSLocalizedString(@"copy") forState:UIControlStateNormal];
        [_privkBackUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _privkBackUpBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _privkBackUpBtn.layer.borderWidth = 0.5;
        _privkBackUpBtn.layer.borderColor = [UIColor colorWithHexString:@"a0a0a0" alpha:0.4].CGColor;
    }
    return _privkBackUpBtn;
}



-(UIBarButtonItem *)backBtnItem {
    if (!_backBtnItem) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 60, 40);
        [leftBtn addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setTitle:BSLocalizedString(@"cancel") forState:UIControlStateNormal];
        [leftBtn setTitleColor:BSCOLOR_000 forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    }
    return _backBtnItem;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.contentSize = CGSizeMake(BSScreen_Width, 720);
    }
    return _scrollView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.frame = CGRectMake(0, 0, BSScreen_Width, 630);
    }
    return _bgView;
}

@end
