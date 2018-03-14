//
//  BSWalletListCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletListCell.h"

@interface BSWalletListCell ()


@property (nonatomic) UILabel *walletName;
@property (nonatomic) UILabel *walletAddress;
@property (nonatomic) UIView * line;

@end

@implementation BSWalletListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSWalletListCellID";
    BSWalletListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSWalletListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self.contentView addSubview:self.walletName];
    [self.contentView addSubview:self.walletAddress];
    [self.contentView addSubview:self.line];

    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    
    [self.walletName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).multipliedBy(0.7f);
        make.left.equalTo(self.contentView).offset(20.0f);
        make.right.equalTo(self.contentView).offset(-20.0f);
    }];
    
    [self.walletAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).multipliedBy(1.3f);
        make.left.right.equalTo(self.walletName);
    }];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(17.5f);
        make.right.equalTo(self.contentView).offset(-17.5f);
        make.height.mas_equalTo(0.5f);
    }];
    
}



- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSWalletData *)model tableView:(UITableView *)tableView {
    
    if (!indexPath.row) {
        //默认钱包
        self.walletName.font = [UIFont boldSystemFontOfSize:19.0f];
        self.walletAddress.font = [UIFont boldSystemFontOfSize:16.0f];
        self.walletAddress.textColor = BSCOLOR_000;
    }else {
        //普通钱包
        self.walletName.font = [UIFont systemFontOfSize:19.0f];
        self.walletAddress.font = [UIFont systemFontOfSize:16.0f];
        self.walletAddress.textColor = BSCOLOR_4B4B4B;
    }
    
    self.walletName.text = model.walletName;
    self.walletAddress.text = model.walletAddress;
}



- (UILabel *)walletName {
    if (!_walletName) {
        _walletName = [UILabel new];
        _walletName.textColor = BSCOLOR_000;
        _walletName.font = [UIFont systemFontOfSize:19.0f];
    }
    return _walletName;
}


- (UILabel *)walletAddress {
    if (!_walletAddress) {
        _walletAddress = [UILabel new];
        _walletAddress.textColor = BSCOLOR_4B4B4B;
        _walletAddress.font = [UIFont systemFontOfSize:16.0f];
        _walletAddress.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _walletAddress;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}
@end
