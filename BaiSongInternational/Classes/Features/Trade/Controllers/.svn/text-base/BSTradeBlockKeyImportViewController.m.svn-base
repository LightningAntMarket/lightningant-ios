//
//  BSTradeBlockKeyImportViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2017/10/25.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeBlockKeyImportViewController.h"
#import "IWTextView.h"
#import "UIViewController+DismissKeyboard.h"

static NSString * GetCheckKey = @"Android/User/checkKey/privkey/%@";

#define TextFieldHeight 50.0f
#define TextFieldWidth 220.0f
@interface BSTradeBlockKeyImportViewController ()<UIAlertViewDelegate>
@property (nonatomic) UILabel * titleLab1;
@property (nonatomic) IWTextView * textView;
@property (nonatomic) UIView * line;
@property (nonatomic) UIButton * importBtn;
@property (nonatomic) UILabel * tipLab;
@end

@implementation BSTradeBlockKeyImportViewController

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
    NSString * url = [NSString stringWithFormat:GetCheckKey,self.textView.text];
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] intValue] == 1) {
            
            BSUser * user =  [[BSDataBaseManager shareInstance] getUserInfo];
            //修改Cache缓存
            user.privkey = self.textView.text;
            
            //更新据库
            [[BSDataBaseManager shareInstance] insertUserInfoToDB:user];
            
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"insert.is.successfully") delegate:self cancelButtonTitle:BSLocalizedString(@"ok") otherButtonTitles:nil, nil];
            [alert show];
        }else {
           
            [self showHint:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - private method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLab1];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.line];
    [self.view addSubview:self.importBtn];
    [self.view addSubview:self.tipLab];
    
    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(75.0f);
        make.left.equalTo(self.view).offset(20.0f);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab1.mas_bottom).offset(34.0f);
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
        make.height.mas_equalTo(60.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20.0f);
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    [self.importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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



#pragma mark- setter && getter

- (UILabel *)titleLab1 {
    if (!_titleLab1) {
        _titleLab1 = [UILabel new];
        _titleLab1.textColor = BSCOLOR_000;
        _titleLab1.font = [UIFont boldSystemFontOfSize:21.0f];
        _titleLab1.text = BSLocalizedString(@"insert wallet");
    }
    return _titleLab1;
}

- (IWTextView *)textView {
    if (!_textView) {
        _textView = [IWTextView new];
        _textView.textColor = BSCOLOR_4B4B4B;
        _textView.font = [UIFont boldSystemFontOfSize:16.0f];
        _textView.placeholder = BSLocalizedString(@"please.input.the.private.key");
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
        [_importBtn setTitle:BSLocalizedString(@"confirm.and.insert") forState:UIControlStateNormal];
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
        _tipLab.textColor = BSCOLOR_4B4B4B;
        _tipLab.font = [UIFont systemFontOfSize:16.0f];
        _tipLab.text = BSLocalizedString(@"key.tip.02");
        _tipLab.numberOfLines = 0 ;
        _tipLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLab;
}



@end
