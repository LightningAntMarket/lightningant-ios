//
//  BSGoodsDetailBottomView.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/1.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailBottomView.h"

@interface BSGoodsDetailBottomView()

@property (strong , nonatomic) UIView      *line;
@property (strong , nonatomic) UILabel     *label;

@property (strong , nonatomic) UIButton    *operateButton;

@end
@implementation BSGoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.line];
        [self addSubview:self.label];
        [self addSubview:self.operateButton];
    
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(self.mas_top).offset(20);
        }];
        
        [self.operateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@38);
            make.width.equalTo(@100);
            make.centerY.equalTo(self.label.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-17);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
        }];
    }
    return self;
}

- (void)setDetailModel:(BSGoodsDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    self.label.text = [NSString stringWithFormat:@"LAP %@",detailModel.goods.price];

    NSInteger pType = detailModel.goods.modetype.integerValue;

    if (pType == PublishType_Oneoff) {
        [self.operateButton setTitle:BSLocalizedString(@"purchase") forState:UIControlStateNormal];
        
        
    }else if(pType == PublishType_Auction){
        [self.operateButton setTitle:BSLocalizedString(@"bid") forState:UIControlStateNormal];
        
        if (detailModel.goods.is_sale.integerValue == 0) {
            self.operateButton.backgroundColor = BSCOLOR_CCC;
            self.operateButton.enabled = NO;
            [self.operateButton setTitle:BSLocalizedString(@"finished") forState:UIControlStateNormal];
        }
    }
}

- (void)operateButtonAction
{
    if ([self.delegate respondsToSelector:@selector(bottomView:didClickButton:)]) {
        [self.delegate bottomView:self didClickButton:self.operateButton];
    }
}

- (UILabel *)label
{
    if (!_label) {
        _label               = [[UILabel alloc] init];
        _label.font          = [UIFont systemFontOfSize:21];
        _label.textColor     = BSCOLOR_337FDD;
    }
    return _label;
}

- (UIButton *)operateButton
{
    if (!_operateButton) {
        _operateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operateButton.layer.cornerRadius  = 17;
        _operateButton.layer.masksToBounds = YES;
        _operateButton.backgroundColor = BSCOLOR_337FDD;
        _operateButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_operateButton addTarget:self action:@selector(operateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operateButton;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}


@end
