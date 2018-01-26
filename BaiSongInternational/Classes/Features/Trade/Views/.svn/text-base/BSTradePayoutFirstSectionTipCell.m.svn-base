//
//  BSTradePayoutFirstSectionTipCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/22.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradePayoutFirstSectionTipCell.h"

#define Multiplied 0.35f

@interface BSTradePayoutFirstSectionTipCell ()
@property (nonatomic) UILabel * titleLab;

@property (nonatomic) UILabel * tipLab;

@end

@implementation BSTradePayoutFirstSectionTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTradePayoutFirstSectionTipCellID";
    BSTradePayoutFirstSectionTipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTradePayoutFirstSectionTipCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
        make.centerY.equalTo(self.contentView).multipliedBy(1 - Multiplied);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).multipliedBy(1 + Multiplied);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel *)model tableView:(UITableView *)tableView {
    
    
    switch (indexPath.row) {
        case 2:
        {
            
            self.titleLab.text = BSLocalizedString(@"transaction.fee");
            self.tipLab.text =BSLocalizedString(@"withdraw.tip.1");
        }
            break;

            
        default:
            break;
    }
    
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:14.0f];
        _titleLab.textColor = BSCOLOR_4B4B4B;
    }
    return _titleLab;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.font = [UIFont systemFontOfSize:14.0f];
        _tipLab.textColor = BSCOLOR_4B4B4B;
    }
    return _tipLab;
}


@end
