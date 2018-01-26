//
//  BSTradeBlockKeyCrossingViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2017/10/25.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeBlockKeyCrossingViewController.h"

#import "BSTradeBlockKeyBackUpViewController.h"
#import "BSTradeBlockKeyImportViewController.h"

#import "BSTabBarViewController.h"
#import "BSRootViewControllerConfig.h"

#define TextFieldHeight 50.0f
#define TextFieldWidth 220.0f

@interface BSTradeBlockKeyCrossingViewController ()
@property (nonatomic) UILabel * titleLab1;
@property (nonatomic) UIButton * createBtn;
@property (nonatomic) UIButton * importBtn;

@property (nonatomic) UILabel * tipLab;
@end

@implementation BSTradeBlockKeyCrossingViewController

#pragma mark- life cycle
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
    if (self.cantGoBack) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    }
}


#pragma mark - touch event
- (void)leftItemClick {
    [self.view endEditing:YES];
    if (self.backToHome) {
        [self dismissViewControllerAnimated:YES completion:nil];
        //返回首页
        BSTabBarViewController *tabBarVC = [BSRootViewControllerConfig shareInstance].tabBarController;
        
        if (tabBarVC.selectedIndex == 3 || tabBarVC.selectedIndex == 4) {
            tabBarVC.selectedIndex = 0;
        }
    }else {
        //返回上级
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

//创建秘钥
- (void)createBtnClick {
    
    BSTradeBlockKeyBackUpViewController * vc = [[BSTradeBlockKeyBackUpViewController alloc]init];
    vc.cantGoBack = self.cantGoBack;
    
    [self.navigationController pushViewController:vc animated:YES];
}

//导入秘钥
- (void)importBtnClick {
   [self.navigationController pushViewController:[BSTradeBlockKeyImportViewController new] animated:YES];
}

#pragma mark - private method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLab1];
  
    [self.view addSubview:self.createBtn];
    [self.view addSubview:self.importBtn];
    
    [self.view addSubview:self.tipLab];
    
    [self layoutCustomViews];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"publish_back_button"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"";
}


- (void)layoutCustomViews {
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(75.0f);
        make.left.equalTo(self.view).offset(20.0f);
    }];
    

    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-(TextFieldHeight/2 + 15.0f));
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(TextFieldWidth);
        make.height.mas_equalTo(TextFieldHeight);
    }];
    
    [self.importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset((TextFieldHeight/2 + 15.0f));
        make.centerX.width.height.equalTo(self.createBtn);
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
        _titleLab1.text = BSLocalizedString(@"create.wallet");
    }
    return _titleLab1;
}


- (UIButton *)createBtn {
    if (!_createBtn) {
        _createBtn = [UIButton new];
        [_createBtn addTarget:self action:@selector(createBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _createBtn.backgroundColor = BSCOLOR_337FDD;
        _createBtn.layer.cornerRadius  = TextFieldHeight/2;
        _createBtn.layer.masksToBounds = YES;
        [_createBtn setTitle:BSLocalizedString(@"generate.private.key") forState:UIControlStateNormal];
        [_createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _createBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _createBtn.layer.borderWidth = 0.5;
        _createBtn.layer.borderColor = [UIColor colorWithHexString:@"a0a0a0" alpha:0.4].CGColor;
    }
    return _createBtn;
}



- (UIButton *)importBtn {
    if (!_importBtn) {
        _importBtn = [UIButton new];
        [_importBtn addTarget:self action:@selector(importBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _importBtn.backgroundColor = [UIColor whiteColor];
        _importBtn.layer.cornerRadius  = TextFieldHeight/2;
        _importBtn.layer.masksToBounds = YES;
        [_importBtn setTitle:BSLocalizedString(@"insert.private.key") forState:UIControlStateNormal];
        [_importBtn setTitleColor:BSCOLOR_337FDD forState:UIControlStateNormal];
        _importBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _importBtn.layer.borderWidth = 0.5;
        _importBtn.layer.borderColor = BSCOLOR_337FDD.CGColor;
    }
    return _importBtn;
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
