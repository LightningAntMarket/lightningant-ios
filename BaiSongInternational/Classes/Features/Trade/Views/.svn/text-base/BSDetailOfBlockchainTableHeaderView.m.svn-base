//
//  BSDetailOfBlockchainTableHeaderView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSDetailOfBlockchainTableHeaderView.h"

@interface BSDetailOfBlockchainTableHeaderView ()
@property (nonatomic) UILabel * titleLab;

@property (nonatomic) UILabel * numLab;
@end

@implementation BSDetailOfBlockchainTableHeaderView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.titleLab];
   
    [self addSubview:self.numLab];
    
    
    [self layoutCustomViews];
}



- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0f);
        make.top.equalTo(self).offset(37.0f);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(25.0);
        make.centerX.equalTo(self);
        make.width.mas_lessThanOrEqualTo (BSScreen_Width - 100);
    }];

}

- (void)configureHeaderViewWithModel:(BSTradeModel *)model {
    self.titleLab.text = BSLocalizedString(@"successfully.transferred");
    
    self.numLab.text = model.qty;
}



- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_000;
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _titleLab;
}



- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [UILabel new];
        _numLab.textColor = BSCOLOR_4B4B4B;
        _numLab.font = [UIFont systemFontOfSize:50.0f];
    }
    return _numLab;
}
@end
