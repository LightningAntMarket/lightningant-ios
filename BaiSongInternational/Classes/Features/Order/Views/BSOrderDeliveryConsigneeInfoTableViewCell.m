//
//  BSOrderDeliveryConsigneeInfoTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/15.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderDeliveryConsigneeInfoTableViewCell.h"

@interface BSOrderDeliveryConsigneeInfoTableViewCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * contentLab;
@property (nonatomic) UIView * line;

@property (nonatomic) BSOrderModel * model;

@end

@implementation BSOrderDeliveryConsigneeInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderDeliveryConsigneeInfoTableViewCellID";
    BSOrderDeliveryConsigneeInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderDeliveryConsigneeInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupViews];
        
    }
    return self;
}

- (void)setupViews {
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.line];
    
    [self layoutCustomView];
}


- (void)layoutCustomView {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30.0f);
        make.left.equalTo(self.contentView).offset(20.0f);
        make.right.equalTo(self.contentView).offset(-20.0f);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(17.0f);
        make.left.right.equalTo(self.titleLab);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.titleLab);
        make.height.mas_equalTo(0.5f);
    }];
    
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView{
    self.model = model;
    self.titleLab.text = [NSString stringWithFormat:@"%@   %@",model.consignee,model.mobile];
    self.contentLab.text = model.fitAddress;
    [self.contentLab BS_setLineSpacingForAll:14.0f];
    [self layoutIfNeeded];

}


+ (CGFloat)heightForCellWithModel:(BSOrderModel *)model{
    
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:14.0f];
    
    CGSize size =[model.fitAddress BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 45, 9999) attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:titleFont}];
    
    
    CGFloat height = 60 + size.height + 30;
    
    return height;
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_4B4B4B;
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.textColor = BSCOLOR_4B4B4B;
        _contentLab.font = [UIFont systemFontOfSize:14.0f];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

@end
