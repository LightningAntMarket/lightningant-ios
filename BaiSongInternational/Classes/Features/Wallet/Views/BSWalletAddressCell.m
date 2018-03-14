//
//  BSWalletAddressCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletAddressCell.h"





@interface BSWalletAddressCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * addressLab;
@property (nonatomic) UIButton * copyerBtn;
@property (nonatomic) UIView * line;
@property (nonatomic) NSIndexPath * indexPath;
@property (nonatomic) BSWalletData * walletData;
@end


@implementation BSWalletAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSWalletAddressCellID";
    BSWalletAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSWalletAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.copyerBtn];
    [self.contentView addSubview:self.addressLab];
    [self.contentView addSubview:self.line];
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0f);
        make.centerY.equalTo(self).multipliedBy(0.7f);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0f);
        make.centerY.equalTo(self).multipliedBy(1.3f);
        make.right.equalTo(self).offset(-65.0f);
    }];
    
    
    [self.copyerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20.0f);
        make.centerY.equalTo(self.addressLab);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSWalletData *)model tableView:(UITableView *)tableView {
    self.indexPath = indexPath;
    self.walletData = model;
    switch (indexPath.row) {
        case 0:
        {
            self.titleLab.text = BSLocalizedString(@"wallet.Lap.address");
            self.addressLab.text = model.walletAddress;
        }
            break;  
        case 1:
        {
            self.titleLab.text = BSLocalizedString(@"wallet.Lap.address");
            self.addressLab.text = @"sadasdasdasdasdasdsadasdasdasdasdadasdaasdadasdadasdadsasdasdasdasdasdasdasdasdasdasdasdasdasd";
            
        }
            break;
            
        default:
            break;
    }
}



- (void)copyerBtnClick {
    switch (self.indexPath.row) {
        case 0:
        {
            UIPasteboard *pboard = [UIPasteboard generalPasteboard];
            pboard.string = self.walletData.walletAddress;
            [self showHint:BSLocalizedString(@"copy.is.successfully")];
        }
            break;
        case 1:
        {
            
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - setter && getter
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_4B4B4B;
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _titleLab;
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab = [UILabel new];
        _addressLab.textColor = BSCOLOR_4B4B4B;
        _addressLab.font = [UIFont systemFontOfSize:12.0f];
        _addressLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _addressLab;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}


- (UIButton *)copyerBtn {
    if (!_copyerBtn) {
        _copyerBtn = [UIButton new];
        [_copyerBtn addTarget:self action:@selector(copyerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_copyerBtn setTitle:BSLocalizedString(@"copy") forState:UIControlStateNormal];
        [_copyerBtn setTitleColor:BSCOLOR_337FDD forState:UIControlStateNormal];
        _copyerBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _copyerBtn;
}
@end
