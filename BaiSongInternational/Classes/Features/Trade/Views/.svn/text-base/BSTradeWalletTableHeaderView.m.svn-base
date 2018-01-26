//
//  BSTradeWalletTableHeaderView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2017/11/7.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeWalletTableHeaderView.h"

@interface BSTradeWalletTableHeaderView()

@property (nonatomic) UIImageView * iconImgView;

@end

@implementation BSTradeWalletTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImgView];
        
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(68.0f);
            make.height.mas_equalTo(76.0f);
        }];
        
//        self.iconImgView.size = self.iconImgView.image.size;
    }
    return self;
}


- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"app_LAP_icon.png"];
    }
    return _iconImgView;
}

@end
