//
//  BSGoodsDetailContactCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailContactCell.h"

@interface BSGoodsDetailContactCell()
@property (strong , nonatomic) UIImageView *contactImage;
@property (strong , nonatomic) UILabel     *contactTitle;
@property (strong , nonatomic) UIView      *line;
@end
@implementation BSGoodsDetailContactCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailContactCellID";
    BSGoodsDetailContactCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        [self.contentView addSubview:self.contactTitle];
        [self.contentView addSubview:self.contactImage];
        [self.contentView addSubview:self.line];
        
        [self.contactTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contactImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@17);
            make.width.equalTo(@17);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
    }
    return self;
}

- (void)setGoods:(BSGoods *)goods
{
    _goods = goods;
}

- (UIImageView *)contactImage
{
    if (!_contactImage) {
        _contactImage               = [[UIImageView alloc] init];
        _contactImage.contentMode = UIViewContentModeScaleAspectFit;
        _contactImage.image = [UIImage imageNamed:@"goods_detail_contact"];
    }
    return _contactImage;
}

- (UILabel *)contactTitle
{
    if (!_contactTitle) {
        _contactTitle               = [[UILabel alloc] init];
        _contactTitle.font          = [UIFont boldSystemFontOfSize:16];
        _contactTitle.text          = BSLocalizedString(@"contact.the.seller");
        _contactTitle.textColor     = BSCOLOR_4B4B4B;
    }
    return _contactTitle;
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
