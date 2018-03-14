//
//  BSWalletControlCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletControlCell.h"


@interface BSWalletControlCell ()

@property (nonatomic) UIImageView *cellImage;
@property (nonatomic) UILabel *cellName;
@property (nonatomic) UIView * line;
@property (nonatomic) NSMutableArray<NSString *> * imageArr;
@property (nonatomic) NSArray<NSString *> * nameArr;

@end


@implementation BSWalletControlCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSWalletControlCellID";
    BSWalletControlCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSWalletControlCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self.contentView addSubview:self.cellImage];
    [self.contentView addSubview:self.cellName];
    [self.contentView addSubview:self.line];
    
    self.imageArr = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        NSString * str = [NSString stringWithFormat:@"cell_mine_setinfo_icon.png"];
        [self.imageArr addObject:str];
    }
    
    self.nameArr = @[BSLocalizedString(@"withdraw.LAP"),BSLocalizedString(@"trade.list"),BSLocalizedString(@"wallet.back.up.your.wallet"),BSLocalizedString(@"wallet.switch.wallet")];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(17.5f);
        make.right.equalTo(self.contentView).offset(-17.5f);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.cellName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(17.5f);
    }];
    
    [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cellName);
        make.right.equalTo(self.contentView).offset(-17.5f);
    }];
    
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSWalletData *)model tableView:(UITableView *)tableView {
    self.cellName.text = self.nameArr[indexPath.row];
    self.cellImage.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
}


- (UILabel *)cellName {
    if (!_cellName) {
        _cellName = [UILabel new];
        _cellName.textColor = BSCOLOR_4B4B4B;
        _cellName.font = [UIFont systemFontOfSize:16.0f];
    }
    return _cellName;
}

- (UIImageView *)cellImage {
    if (!_cellImage) {
        _cellImage = [UIImageView new];
        _cellImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _cellImage;
}


- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}
@end
