//
//  BSTaskPublishGuideFooterView.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/7.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishGuideFooterView.h"

@interface BSTaskPublishGuideFooterView ()
@property (nonatomic) UIImageView * imgView;
@property (nonatomic) UILabel *lab;
@end

@implementation BSTaskPublishGuideFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imgView];
        [self addSubview:self.lab];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.bottom.equalTo(self.lab).offset(-3);
            make.height.width.mas_equalTo(15);
        }];
        
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(self.imgView.mas_right).offset(5);
        }];
    }
    return self;
}



- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"chat_add_cell.png"];
    }
    return _imgView;
}

- (UILabel *)lab {
    if (!_lab) {
        _lab = [UILabel new];
        _lab.textColor = BSCOLOR_337FDD;
        _lab.font = [UIFont systemFontOfSize:18];
        _lab.text = BSLocalizedString(@"LN_localizable_2.0_33");
    }
    return _lab;
}
@end
