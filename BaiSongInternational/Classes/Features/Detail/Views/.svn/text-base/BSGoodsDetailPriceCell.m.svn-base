//
//  BSGoodsDetailPriceCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailPriceCell.h"

@interface BSGoodsDetailPriceCell()

@property (strong , nonatomic) UIImageView *imageView1;
@property (strong , nonatomic) UILabel     *label1;

@property (strong , nonatomic) UIImageView *imageView2;
@property (strong , nonatomic) UILabel     *label2;

@property (strong , nonatomic) UIImageView *imageView3;
@property (strong , nonatomic) UILabel     *label3;

@property (strong , nonatomic) UIView  *line;

@end

@implementation BSGoodsDetailPriceCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailPriceCellID";
    BSGoodsDetailPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailPriceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        
        [self.contentView addSubview:self.imageView1];
        [self.contentView addSubview:self.imageView2];
        [self.contentView addSubview:self.imageView3];

        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label3];
        
        [self.contentView addSubview:self.line];

        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.contentView.mas_top).offset(30);
            make.width.equalTo(@13);
            make.height.equalTo(@12);
            
        }];
        
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.imageView1.mas_bottom).offset(30);
            make.width.equalTo(@13);
            make.height.equalTo(@12);
            
        }];
        
        [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.imageView2.mas_bottom).offset(30);
            make.width.equalTo(@13);
            make.height.equalTo(@12);
            
        }];
        
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView1.mas_right).offset(8);
            make.centerY.equalTo(self.imageView1.mas_centerY);
        }];
        
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView2.mas_right).offset(8);
            make.centerY.equalTo(self.imageView2.mas_centerY);
        }];
        
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView3.mas_right).offset(8);
            make.centerY.equalTo(self.imageView3.mas_centerY);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];

//        [self commonInit];
    }
    return self;
}


- (void)setGoods:(BSGoods *)goods
{
    _goods = goods;
    
    self.label1.text = [NSString stringWithFormat:@"%@: %@LAP",BSLocalizedString(@"current.price"),goods.price];
    self.label2.text = [NSString stringWithFormat:@"%@: %@",BSLocalizedString(@"way.of.logistics"),[goods.posttype isEqualToString:@"1"] ? BSLocalizedString(@"mail.fee.included"):BSLocalizedString(@"pay.on.arrival")];
    self.label3.text = [NSString stringWithFormat:@"%@: %@",BSLocalizedString(@"delivery.place"),goods.commodityaddress];
    
    PublishType type = goods.modetype.integerValue;
    if (type == PublishType_Auction) {
        self.imageView1.image = [UIImage imageNamed:@"goods_mode_auction_1"];

    }else{
        self.imageView1.image = [UIImage imageNamed:@"goods_mode_auction_2"];
    }
}

-(UIImageView *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
        _imageView1.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView1;
}

- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.textColor = [UIColor colorWithHexString:@"4b4b4b"];
        _label1.font = [UIFont systemFontOfSize:14];
    }
    return _label1;
}

-(UIImageView *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] init];
        _imageView2.contentMode = UIViewContentModeScaleAspectFill;
        _imageView2.image = [UIImage imageNamed:@"goods_detail_youfei"];

    }
    return _imageView2;
}

- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.textColor = [UIColor colorWithHexString:@"4b4b4b"];
        _label2.font = [UIFont systemFontOfSize:14];
    }
    return _label2;
}

-(UIImageView *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] init];
        _imageView3.contentMode = UIViewContentModeScaleAspectFill;
        _imageView3.image = [UIImage imageNamed:@"goods_detail_dizhi"];

    }
    return _imageView3;
}

- (UILabel *)label3
{
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.textColor = [UIColor colorWithHexString:@"4b4b4b"];
        _label3.font = [UIFont systemFontOfSize:14];
    }
    return _label3;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
