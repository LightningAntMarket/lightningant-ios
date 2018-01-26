//
//  BSTradeWalletTableListCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeListTableCell.h"

#define  OFFSET 22.0f

@interface BSTradeListTableCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * timeLab;
@property (nonatomic) UILabel * numLab;
@property (nonatomic) UIView * line;
@end

@implementation BSTradeListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTradeListTableCellID";
    BSTradeListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTradeListTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.line];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20.0f);
        make.centerY.equalTo(self.contentView).offset(-OFFSET);
        make.right.mas_equalTo(self.contentView.mas_centerX).offset(30.0f);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20.0f);
        make.centerY.equalTo(self.contentView).offset(OFFSET);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20.0f);
        make.centerY.equalTo(self.contentView).offset(-OFFSET);
        make.left.mas_equalTo(self.titleLab.mas_right);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];

}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel *)model tableView:(UITableView *)tableView {

    

    self.titleLab.text = model.addresses;
    
    self.timeLab.text = [model.time timeYMDFromTimestamp];
    
    self.numLab.text = [NSString stringWithFormat:@"%@ LAP",model.qty];

    
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_337FDD;
        _titleLab.font = [UIFont systemFontOfSize:14.0f];
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.textColor = BSCOLOR_A7A7A7;
        _timeLab.font = [UIFont systemFontOfSize:12.0f];
    }
    return _timeLab;
}

- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [UILabel new];
        _numLab.textColor = BSCOLOR_4B4B4B;
        _numLab.font = [UIFont systemFontOfSize:14.0f];
        _numLab.textAlignment = NSTextAlignmentRight;
    }
    return _numLab;
}


- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}
@end
