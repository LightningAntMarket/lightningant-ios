//
//  BSOrderDetailConsigneeInfoTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/19.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderDetailConsigneeInfoTableViewCell.h"

@interface BSOrderDetailConsigneeInfoTableViewCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * telLab;
@property (nonatomic) UILabel * contentLab;

@property (nonatomic) UIButton * messageBtn;
@property (nonatomic) UIImageView * messageImgView;

@property (nonatomic) UIView * line;

@property (nonatomic) BSOrderModel * model;

@end

@implementation BSOrderDetailConsigneeInfoTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderDetailConsigneeInfoTableViewCellID";
    BSOrderDetailConsigneeInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderDetailConsigneeInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentLab addSubview:self.telLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.line];
    
    [self.contentView addSubview:self.messageBtn];
    [self.contentView addSubview:self.messageImgView];
    
    [self layoutCustomView];
}


- (void)layoutCustomView {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30.0f);
        make.left.equalTo(self.contentView).offset(20.0f);
        make.right.equalTo(self.contentView).offset(-20.0f);
    }];
    
    [self.telLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(17.0f);
        make.left.right.equalTo(self.titleLab);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.telLab.mas_bottom).offset(17.0f);
        make.left.right.equalTo(self.titleLab);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.titleLab);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.height.mas_equalTo(40.0f);
    }];
    
    [self.messageImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.right.equalTo(self.contentView).offset(-20.0f);
    }];
    
    self.messageImgView.size = self.messageImgView.image.size;
    
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView{
    self.model = model;
    self.titleLab.text = model.consignee;
    self.telLab.text = model.mobile;
    
    NSString * content =  [NSString stringWithFormat:@"%@ %@",model.city,model.address];
    
    if (!model.city.length) {
        content = model.address;
    }
    
    self.contentLab.text = content;
    [self.contentLab BS_setLineSpacingForAll:14.0f];
    [self layoutIfNeeded];

}


+ (CGFloat)heightForCellWithModel:(BSOrderModel *)model{
    
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:14.0f];
    
    CGSize size = [[NSString stringWithFormat:@"%@ %@",model.city,model.address]BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 45, 9999) attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:titleFont}];
    
    
    CGFloat height = 60 + 20+ size.height + 40;
    
    return height;
}


- (void)messageBtnClick {
    BSConvenientOperationManager *manager = [BSConvenientOperationManager shareInstance];
    [manager pushChatController:[self getCurrentViewController] phoneNumber:self.model.uid conversationType:EMConversationTypeChat];
    manager.toPhoto    = self.model.face;
    manager.toNickname = self.model.nickname;
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_4B4B4B;
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
    }
    return _titleLab;
}


- (UILabel *)telLab {
    if (!_telLab) {
        _telLab = [UILabel new];
        _telLab.textColor = BSCOLOR_4B4B4B;
        _telLab.font = [UIFont systemFontOfSize:16.0f];
    }
    return _telLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.textColor = BSCOLOR_A7A7A7;
        _contentLab.font = [UIFont systemFontOfSize:14.0f];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [UIButton new];
        [_messageBtn addTarget:self action:@selector(messageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _messageBtn.hidden = YES;
    }
    return _messageBtn;
}

- (UIImageView *)messageImgView {
    if (!_messageImgView) {
        _messageImgView = [UIImageView new];
        _messageImgView.image = [UIImage imageNamed:@"cell_order_messages.png"];
        _messageImgView.hidden = YES;
    }
    return _messageImgView;
}

@end
