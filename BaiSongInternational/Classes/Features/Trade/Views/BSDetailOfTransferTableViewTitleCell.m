//
//  BSDetailOfTransferTableViewTitleCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/27.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSDetailOfTransferTableViewTitleCell.h"

@interface BSDetailOfTransferTableViewTitleCell ()

@property (nonatomic) UILabel * titleLab;

@end

@implementation BSDetailOfTransferTableViewTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSDetailOfTransferTableViewTitleCellID";
    BSDetailOfTransferTableViewTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSDetailOfTransferTableViewTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    

}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    
    
    self.titleLab.text = BSLocalizedString(@"transfer.LAP");

}



- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:21.0f];
        _titleLab.textColor = BSCOLOR_000;
    }
    return _titleLab;
}


@end
