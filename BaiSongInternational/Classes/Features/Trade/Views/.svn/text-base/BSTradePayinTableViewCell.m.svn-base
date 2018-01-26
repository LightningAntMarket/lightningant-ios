//
//  BSTradePayinTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/25.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradePayinTableViewCell.h"



#define LineSpacing 14.0f
@interface BSTradePayinTableViewCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * tipLab;
@end

@implementation BSTradePayinTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTradePayinTableViewCellID";
    BSTradePayinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTradePayinTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
        make.top.equalTo(self).offset(30.0f);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-30.0f);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel *)model tableView:(UITableView *)tableView {
    
    
    self.titleLab.text = BSLocalizedString(@"address.of.receiving.LAP");
    BSUser * user = [[BSDataBaseManager shareInstance] getUserInfo];
    self.tipLab.text = user.blockaddress;
    [self.tipLab BS_setLineSpacingForAll:LineSpacing];
    [self layoutIfNeeded];
}



+ (CGFloat)heightForCellWithModel:(id)model {
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];
    
    BSUser * user = [[BSDataBaseManager shareInstance] getUserInfo];
    CGSize size = [user.blockaddress BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 45, 9999) attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:titleFont}];
    
    
    CGFloat height = 85 + size.height + 30;
    
    return height;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
        _titleLab.textColor = BSCOLOR_000;
    }
    return _titleLab;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.font = [UIFont systemFontOfSize:14.0f];
        _tipLab.textColor = BSCOLOR_337FDD;
        _tipLab.numberOfLines = 0;
    }
    return _tipLab;
}


@end
