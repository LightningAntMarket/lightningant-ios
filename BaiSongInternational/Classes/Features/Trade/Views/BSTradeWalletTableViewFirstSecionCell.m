//
//  BSTradeWalletTableViewFirstSecionCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeWalletTableViewFirstSecionCell.h"

@interface BSTradeWalletTableViewFirstSecionCell ()

@property (nonatomic) UILabel * titleLab;
//@property (nonatomic) UIImageView * iconImgView;
@property (nonatomic) UILabel * numLab;
@property (nonatomic) UIView * line;
@end

@implementation BSTradeWalletTableViewFirstSecionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTradeWalletTableViewFirstSecionCellID";
    BSTradeWalletTableViewFirstSecionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTradeWalletTableViewFirstSecionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
//    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.line];
    
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0f);
        make.top.equalTo(self).offset(37.0f);
    }];
    
//    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.numLab.mas_left).offset(-10);
//        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(37.0f);
//    }];
    
//    self.iconImgView.size = self.iconImgView.image.size;
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(25.0);
        make.centerX.equalTo(self);
        make.width.mas_lessThanOrEqualTo (BSScreen_Width - 100);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel *)model tableView:(UITableView *)tableView {
    switch (indexPath.row) {
        case 0:
        {
            self.titleLab.text = BSLocalizedString(@"available.LAP.01");
            self.numLab.text = model.balance;
        }
            break;
        case 1:
        {
            self.titleLab.text = BSLocalizedString(@"frozen");
            self.numLab.text = model.lockbalance;
        }
            break;
            
        default:
            break;
    }
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_000;
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _titleLab;
}

//- (UIImageView *)iconImgView {
//    if (!_iconImgView) {
//        _iconImgView = [UIImageView new];
//        _iconImgView.image = [UIImage imageNamed:@"icon_LAP.png"];
//    }
//    return _iconImgView;
//}

- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [UILabel new];
        _numLab.textColor = BSCOLOR_4B4B4B;
        _numLab.font = [UIFont systemFontOfSize:50.0f];
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
