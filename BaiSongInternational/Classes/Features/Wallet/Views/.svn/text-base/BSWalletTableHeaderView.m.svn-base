//
//  BSWalletTableHeaderView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletTableHeaderView.h"

@interface BSWalletTableHeaderView()

@property (nonatomic) UIImageView * iconImgView;

@property (nonatomic) UILabel * numLab;

@end


@implementation BSWalletTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImgView];
        [self addSubview:self.numLab];
        
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(15.0f);
            make.width.mas_equalTo(68.0f);
            make.height.mas_equalTo(76.0f);
        }];
        
        [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(self.iconImgView.mas_bottom).offset(15.0f);
            make.width.equalTo(self).offset(-40.0f);
        }];

    }
    return self;
}




- (void)configureHeaderViewWithModel:(BSWalletData *)model {
    
    self.numLab.text = [NSString stringWithFormat:@"%@ LAP",model.balance];
}


- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"app_LAP_icon.png"];
    }
    return _iconImgView;
}

- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [UILabel new];
        _numLab.textColor = BSCOLOR_4B4B4B;
        _numLab.font = [UIFont systemFontOfSize:21.0f];
        _numLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numLab;
}
@end
