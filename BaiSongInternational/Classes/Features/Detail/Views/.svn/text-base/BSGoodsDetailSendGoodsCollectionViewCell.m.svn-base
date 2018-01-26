//
//  BSGoodsDetailSendGoodsCollectionViewCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailSendGoodsCollectionViewCell.h"

@interface BSGoodsDetailSendGoodsCollectionViewCell()

@property (strong , nonatomic) UIImageView *goodsImageView;
@property (strong , nonatomic) UILabel     *goodsTitle;
@property (strong , nonatomic) UILabel     *goodsPrice;

@end

@implementation BSGoodsDetailSendGoodsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.goodsImageView];
        [self.contentView addSubview:self.goodsTitle];
        [self.contentView addSubview:self.goodsPrice];
        
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(self.contentView.mas_width);
            
        }];
        
        [self.goodsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.goodsImageView.mas_bottom).offset(28);
            make.right.equalTo(self.contentView.mas_right);
        }];

        
        [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.goodsTitle.mas_bottom).offset(18);
        }];
        
    }
    return self;
}

- (void)setGoods:(BSGoods *)goods
{
    _goods = goods;
    
    [self.goodsImageView bs_setImageWithURL:[NSURL URLWithString:goods.cover] placeholderImage:nil];
    self.goodsTitle.text = goods.title;
    self.goodsPrice.text = [NSString stringWithFormat:@"LAP %@",goods.price];
    [self.goodsTitle BS_setLineSpacing:9];
    [self layoutIfNeeded];

}

- (UIImageView *)goodsImageView
{
    if (!_goodsImageView) {
        _goodsImageView                   = [[UIImageView alloc] init];
        _goodsImageView.contentMode       = UIViewContentModeScaleAspectFill;
        _goodsImageView.layer.borderWidth = 0.5;
        _goodsImageView.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _goodsImageView.backgroundColor = BSCOLOR_F3F3F3;
        _goodsImageView.layer.masksToBounds = YES;
    }
    return _goodsImageView;
}


- (UILabel *)goodsPrice
{
    if (!_goodsPrice) {
        _goodsPrice             = [[UILabel alloc] init];
        _goodsPrice.font        = [UIFont systemFontOfSize:15];
        _goodsPrice.textColor   = BSCOLOR_337FDD;
    }
    return _goodsPrice;
}

- (UILabel *)goodsTitle
{
    if (!_goodsTitle) {
        _goodsTitle               = [[UILabel alloc] init];
        _goodsTitle.numberOfLines = 2;
        _goodsTitle.font          = [UIFont systemFontOfSize:14];
        _goodsTitle.textColor     = BSCOLOR_4B4B4B;
    }
    return _goodsTitle;
}
@end
