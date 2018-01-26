//
//  BSBusinessDetailTableViewDescriptionCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2017/10/27.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBusinessDetailTableViewDescriptionCell.h"
#define Multiplied 0.3f
@interface BSBusinessDetailTableViewDescriptionCell()
@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * descriptionLab;
@end


@implementation BSBusinessDetailTableViewDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSBusinessDetailTableViewDescriptionCellID";
    BSBusinessDetailTableViewDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSBusinessDetailTableViewDescriptionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.descriptionLab];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1 - Multiplied);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.descriptionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1 + Multiplied);;
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    
    
    self.titleLab.text = @"Description";
    self.descriptionLab.text = model.msg?model.msg:@"None";
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        _titleLab.textColor = BSCOLOR_4B4B4B;
    }
    return _titleLab;
}

- (UILabel *)descriptionLab {
    if (!_descriptionLab) {
        _descriptionLab = [UILabel new];
        _descriptionLab.font = [UIFont systemFontOfSize:16.0f];
        _descriptionLab.textColor = BSCOLOR_4B4B4B;
    }
    return _descriptionLab;
}
@end
