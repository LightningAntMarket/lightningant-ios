//
//  BSOrderStatusTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/19.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderStatusTableViewCell.h"

@interface BSOrderStatusTableViewCell()

@property (nonatomic) UIImageView * statusImgView;
@property (nonatomic) UILabel * statusLab;
@property (nonatomic) UIView * line;
@end

@implementation BSOrderStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderStatusTableViewCellID";
    BSOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.statusImgView];
    [self.contentView addSubview:self.statusLab];
    [self.contentView addSubview:self.line];
    
    [self layoutCustomviews];
}

- (void)layoutCustomviews {
    [self.statusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
    }];
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(self.statusImgView.mas_right).offset(15.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.statusImgView);
        make.width.mas_equalTo(175.0f);
        make.height.mas_equalTo(0.5f);
    }];
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView{
    
    self.statusImgView.image = [UIImage imageNamed:model.orderStatusImg];
    self.statusImgView.size = self.statusImgView.image.size;
    
    self.statusLab.text = model.orderStatus;
}


- (UIImageView *)statusImgView {
    if (!_statusImgView) {
        _statusImgView = [UIImageView new];
        _statusImgView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _statusImgView;
}

-(UILabel *)statusLab {
    if (!_statusLab) {
        _statusLab = [UILabel new];
        _statusLab.font = [UIFont boldSystemFontOfSize:16.0f];
        _statusLab.textColor = BSCOLOR_000;
    }
    return _statusLab;
}


- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}
@end
