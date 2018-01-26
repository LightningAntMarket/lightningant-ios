//
//  BSGoodsDetailDescCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailDescCell.h"
#import "BSGoodsDetailModel.h"

@interface BSGoodsDetailDescCell()

@property (strong , nonatomic) UILabel     *descTitle;
@property (strong , nonatomic) UILabel     *descContent;
@property (strong , nonatomic) UIView      *line;

@end

@implementation BSGoodsDetailDescCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailDescCellID";
    BSGoodsDetailDescCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailDescCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        [self.contentView addSubview:self.descTitle];
        [self.contentView addSubview:self.descContent];
        [self.contentView addSubview:self.line];
        
        [self.descTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.contentView.mas_top).offset(28);
        }];
        
        [self.descContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.top.equalTo(self.descTitle.mas_bottom).offset(24);
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

+ (CGFloat)heightForCellWithModel:(BSGoods *)goods
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:9];

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize size = [goods.desc BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 34, CGFLOAT_MAX) attributes:attributes];
    return size.height + 75.0f +23.0f;
}


- (void)setGoods:(BSGoods *)goods
{
    _goods = goods;
    self.descTitle.text   = BSLocalizedString(@"description.of.commodity");
    self.descContent.text = goods.desc;
    [self.descContent BS_setLineSpacing:9];
    [self layoutIfNeeded];

}

- (UILabel *)descTitle
{
    if (!_descTitle) {
        _descTitle               = [[UILabel alloc] init];
        _descTitle.font          = [UIFont boldSystemFontOfSize:16];
        _descTitle.text          = BSLocalizedString(@"description.of.commodity");
        _descTitle.textColor     = BSCOLOR_4B4B4B;
    }
    return _descTitle;
}

- (UILabel *)descContent
{
    if (!_descContent) {
        _descContent               = [[UILabel alloc] init];
        _descContent.font          = [UIFont systemFontOfSize:14];
        _descContent.numberOfLines = 0;
        _descContent.textColor     = BSCOLOR_4B4B4B;
    }
    return _descContent;
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
