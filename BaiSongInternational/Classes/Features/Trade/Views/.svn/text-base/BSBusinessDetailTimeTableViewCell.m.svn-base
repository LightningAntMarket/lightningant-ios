//
//  BSBusinessDetailTimeTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBusinessDetailTimeTableViewCell.h"


#define Multiplied 0.3f

@interface BSBusinessDetailTimeTableViewCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * timeLab;

@end

@implementation BSBusinessDetailTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSBusinessDetailTimeTableViewCellID";
    BSBusinessDetailTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSBusinessDetailTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1 - Multiplied);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1 + Multiplied);;
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    
    
    self.titleLab.text = BSLocalizedString(@"description.of.transferring");
    self.timeLab.text = [model.time timeYMDFromTimestamp];
}



- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        _titleLab.textColor = BSCOLOR_4B4B4B;
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = [UIFont systemFontOfSize:12.0f];
        _timeLab.textColor = BSCOLOR_A7A7A7;
    }
    return _timeLab;
}

@end
