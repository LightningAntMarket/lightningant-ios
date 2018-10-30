//
//  BSTaskDetailTipCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailTipCell.h"

@interface BSTaskDetailTipCell()
@property (nonatomic) UILabel *tipLab;
@end

@implementation BSTaskDetailTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskDetailTipCellID";
    BSTaskDetailTipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskDetailTipCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.tipLab];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 20, 30, 20));
    }];
}



- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.font = [UIFont systemFontOfSize:12];
        _tipLab.textColor = BSCOLOR_4B4B4B;
        _tipLab.numberOfLines = 0;
        _tipLab.text = BSLocalizedString(@"LN_localizable_2.0_10");
        [_tipLab BS_setLineSpacing:17];
    }
    return _tipLab;
}

@end
