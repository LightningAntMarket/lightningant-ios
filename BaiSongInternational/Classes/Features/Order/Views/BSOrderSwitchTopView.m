//
//  BSOrderSwitchTopView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderSwitchTopView.h"

@interface BSOrderSwitchTopView ()

@property (nonatomic) BSOrderSwitchTopViewType type;
@property (nonatomic) NSArray<NSString *> * btnTitleArr;
@property (nonatomic) NSMutableArray<UIButton *> * btnArr;
@property (nonatomic) UIView * line;
@end

@implementation BSOrderSwitchTopView


- (instancetype)initWithType:(BSOrderSwitchTopViewType)type {
    self = [super init];
    if (self) {
        self.type = type;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self configBtnTitleArr];
    [self configBtnArr];
    [self addSubview:self.line];
    [self layoutCustomViews];
    
}

- (void)configBtnTitleArr {
    switch (self.type) {
        case BSOrderSwitchTopViewType_OrderAuction:
        {
            self.btnTitleArr = @[BSLocalizedString(@"successful"),BSLocalizedString(@"in.progress"),BSLocalizedString(@"order.failed")];
        }
            break;
        case BSOrderSwitchTopViewType_OrderIssued:
        {
            self.btnTitleArr = @[BSLocalizedString(@"auction"),BSLocalizedString(@"fixed.price"),BSLocalizedString(@"in.progress")];
        }
            break;
            
        default:
            break;
    }
}

- (void)configBtnArr {
    for (int i = 0; i < self.btnTitleArr.count; i ++) {
        UIButton * btn = [UIButton new];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.btnTitleArr[i] forState:UIControlStateNormal];
        [btn setTitle:self.btnTitleArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:BSCOLOR_000 forState:UIControlStateNormal];
        [btn setTitleColor:BSCOLOR_337FDD forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        btn.tag = i+100;
        [self addSubview:btn];
        [self.btnArr addObject:btn];
    }
    
    self.btnArr[0].selected = YES;
    
    
}

- (void)layoutCustomViews {

    [self updateConstraintsIfNeeded];
    
    for (int i = 0; i < self.btnArr.count; i ++) {
        [self.btnArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            if (!i) {
                make.left.equalTo(self).offset(20.0f);
            }else {
                make.left.mas_equalTo(self.btnArr[i - 1].mas_right).offset(30.0f);
            }
        }];
    }
    
    

    
    [self layoutIfNeeded];
    
    
    self.line.height = 0.5;
    self.line.left = self.btnArr[0].left;
    self.line.width = self.btnArr[0].width;
    self.line.top = BSOrderSwitchTopViewHeight - 0.5;
    
}




- (void)btnClick:(UIButton *)currentBtn {
    for (UIButton * btn in self.btnArr) {
        btn.selected = NO;
    }
    
    currentBtn.selected = YES;
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.line.left = currentBtn.left;
        self.line.width = currentBtn.width;
    }];
    
    if ([self.delegate respondsToSelector:@selector(orderSwitchTopViewBtnClickByIndex:)]) {
        [self.delegate orderSwitchTopViewBtnClickByIndex:currentBtn.tag - 100];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    for (int i = 0; i < 3; i ++) {
        UIButton * btn = (UIButton *)[self viewWithTag:i+100];
        btn.selected = (btn.tag - 100 == currentIndex);
        if (btn.tag - 100 == currentIndex) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.line.centerX = btn.centerX;
            }];
        }
    }
  
}

- (NSMutableArray<UIButton *> *)btnArr {
    if (!_btnArr) {
        _btnArr = [NSMutableArray new];
    }
    return _btnArr;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_337FDD;
    }
    return _line;
}

@end
