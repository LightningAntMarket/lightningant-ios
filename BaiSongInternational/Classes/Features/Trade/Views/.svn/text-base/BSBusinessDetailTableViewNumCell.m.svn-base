//
//  BSBusinessDetailTableViewNumCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBusinessDetailTableViewNumCell.h"


@interface BSBusinessDetailTableViewNumCell ()

@property (nonatomic) UILabel * numLab;

@property (nonatomic) UIView * line;

@end

@implementation BSBusinessDetailTableViewNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSBusinessDetailTableViewNumCellID";
    BSBusinessDetailTableViewNumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSBusinessDetailTableViewNumCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.line];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {

    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(100.0f);
        make.left.equalTo(self.numLab);
        make.height.mas_equalTo(0.5f);
    }];
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    
    self.numLab.text = [NSString stringWithFormat:@"%@ LAP",model.qty];
}



- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [UILabel new];
        _numLab.font = [UIFont systemFontOfSize:21.0f];
        _numLab.textColor = BSCOLOR_4B4B4B;
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
