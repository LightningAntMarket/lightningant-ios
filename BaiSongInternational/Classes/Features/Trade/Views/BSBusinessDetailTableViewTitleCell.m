//
//  BSBusinessDetailTableViewTitleCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBusinessDetailTableViewTitleCell.h"

#define Multiplied 0.3f

@interface BSBusinessDetailTableViewTitleCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * tipLab;

@end


@implementation BSBusinessDetailTableViewTitleCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSBusinessDetailTableViewTitleCellID";
    BSBusinessDetailTableViewTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSBusinessDetailTableViewTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.tipLab];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1 - Multiplied);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1 + Multiplied);;
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    
    
    self.titleLab.text = BSLocalizedString(@"details.of.the.trade");
    self.tipLab.text = @"be forzen Successful purchase";
}



- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:21.0f];
        _titleLab.textColor = BSCOLOR_000;
    }
    return _titleLab;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.font = [UIFont systemFontOfSize:12.0f];
        _tipLab.textColor = BSCOLOR_A7A7A7;
    }
    return _tipLab;
}

@end
