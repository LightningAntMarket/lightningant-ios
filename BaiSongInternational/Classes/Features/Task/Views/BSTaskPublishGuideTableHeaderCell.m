//
//  BSTaskPublishGuideTableHeaderCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/7.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishGuideTableHeaderCell.h"


@interface BSTaskPublishGuideTableHeaderCell ()
@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * tipLab;

@end

@implementation BSTaskPublishGuideTableHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskPublishGuideTableHeaderCellID";
    BSTaskPublishGuideTableHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskPublishGuideTableHeaderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
        make.top.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.contentView).offset(20);
    }];
    
    
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:24];
        _titleLab.textColor = BSCOLOR_000;
        _titleLab.text = BSLocalizedString(@"添加操作说明");
    }
    return _titleLab;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.font = [UIFont systemFontOfSize:14.0f];
        _tipLab.textColor = BSCOLOR_888;
        _tipLab.text = BSLocalizedString(@"LN_localizable_2.0_31");
        [_tipLab BS_setLineSpacing:14];
        _tipLab.numberOfLines = 0;
    }
    return _tipLab;
}
@end
