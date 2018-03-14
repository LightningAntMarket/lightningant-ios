//
//  BSWalletPastePrivateViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletPastePrivateViewController.h"

#import "IWTextView.h"
#import "UIViewController+DismissKeyboard.h"
#import "BSKeychain.h"
#import "BSUnderlineTextField.h"

#import "BSWalletCache.h"


#define TextFieldHeight 50.0f
#define TextFieldWidth 220.0f

@interface BSWalletPastePrivateViewController ()<UIAlertViewDelegate>
@property (nonatomic, copy) NSString * privateKey;


@property (nonatomic) UILabel * titleLab1;
@property (nonatomic) IWTextView * textView;
@property (nonatomic) UIView * line;
@property (nonatomic) UIButton * importBtn;
@property (nonatomic) UILabel  * waringLab;
@property (nonatomic) UILabel  * tipLab;

@property (nonatomic) UIScrollView * scrollView;
@property (nonatomic) UIView * bgView;
@end

@implementation BSWalletPastePrivateViewController

- (instancetype)initWithPrivateKey:(NSString *)privateKey
{
    self = [super init];
    if (self) {
        self.privateKey = privateKey;
    }
    return self;
}

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
    [self setupForDismissKeyboard];
}

-(void)dealloc {
    [self clearKeyboardNotificationAndGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}




//导入
- (void)importBtnClick {
    if ([self.privateKey isEqualToString:self.textView.text]) {
     
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"wallet.tip.4") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:BSLocalizedString(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        [self showHint:BSLocalizedString(@"wallet.wrong.keystore")];
    }
}



#pragma mark - private method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bgView];
    
    [self.bgView addSubview:self.titleLab1];
    [self.bgView addSubview:self.textView];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.importBtn];
    [self.bgView addSubview:self.tipLab];
    [self.bgView addSubview:self.waringLab];
    
    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(25.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLab1.mas_bottom).offset(25.0f);
        make.left.equalTo(self.bgView).offset(18.0f);
        make.right.equalTo(self.bgView).offset(-18.0f);
        make.height.mas_equalTo(220.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
        make.right.equalTo(self.bgView).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    [self.importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line).offset(35.0f);
        make.centerX.equalTo(self.bgView);
        make.width.mas_equalTo(TextFieldWidth);
        make.height.mas_equalTo(TextFieldHeight);
    }];
    
    [self.waringLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.importBtn.mas_bottom).offset(50.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
        make.right.equalTo(self.bgView).offset(-20.0f);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.waringLab.mas_bottom).offset(25.0f);
        make.left.equalTo(self.bgView).offset(20.0f);
        make.right.equalTo(self.bgView).offset(-20.0f);
    }];
    
    
}



#pragma mark- setter && getter

- (UILabel *)titleLab1 {
    if (!_titleLab1) {
        _titleLab1 = [UILabel new];
        _titleLab1.textColor = BSCOLOR_000;
        _titleLab1.font = [UIFont boldSystemFontOfSize:21.0f];
        _titleLab1.text = BSLocalizedString(@"wallet.confirm.keystore.back.up");
    }
    return _titleLab1;
}

- (IWTextView *)textView {
    if (!_textView) {
        _textView = [IWTextView new];
        _textView.textColor = BSCOLOR_4B4B4B;
        _textView.font = [UIFont boldSystemFontOfSize:16.0f];
        _textView.placeholder = BSLocalizedString(@"wallet.tip.7");
    }
    return _textView;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

- (UIButton *)importBtn {
    if (!_importBtn) {
        _importBtn = [UIButton new];
        [_importBtn addTarget:self action:@selector(importBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _importBtn.backgroundColor = BSCOLOR_337FDD;
        _importBtn.layer.cornerRadius  = TextFieldHeight/2;
        _importBtn.layer.masksToBounds = YES;
        [_importBtn setTitle:BSLocalizedString(@"wallet.complete") forState:UIControlStateNormal];
        [_importBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _importBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _importBtn.layer.borderWidth = 0.5;
        _importBtn.layer.borderColor = [UIColor colorWithHexString:@"a0a0a0" alpha:0.4].CGColor;
    }
    return _importBtn;
}


- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.textColor = BSCOLOR_FF5B3B;
        _tipLab.font = [UIFont systemFontOfSize:16.0f];
        _tipLab.text = BSLocalizedString(@"wallet.tip.5");
        _tipLab.numberOfLines = 0 ;
        _tipLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLab;
}

- (UILabel *)waringLab {
    if (!_waringLab) {
        _waringLab = [UILabel new];
        _waringLab.textColor = BSCOLOR_FF5B3B;
        _waringLab.font = [UIFont systemFontOfSize:16.0f];
        _waringLab.text = BSLocalizedString(@"warning");
        _waringLab.textAlignment = NSTextAlignmentCenter;
    }
    return _waringLab;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        CGSize tip_size = [BSLocalizedString(@"wallet.tip.5") BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 40, MAXFLOAT) font:[UIFont systemFontOfSize:16]];
        _scrollView.contentSize = CGSizeMake(BSScreen_Width, 600 + tip_size.height);
    }
    return _scrollView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        CGSize tip_size = [BSLocalizedString(@"wallet.tip.5") BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 40, MAXFLOAT) font:[UIFont systemFontOfSize:16]];
        _bgView.frame = CGRectMake(0, 0, BSScreen_Width, 600 + tip_size.height);
    }
    return _bgView;
}

@end
