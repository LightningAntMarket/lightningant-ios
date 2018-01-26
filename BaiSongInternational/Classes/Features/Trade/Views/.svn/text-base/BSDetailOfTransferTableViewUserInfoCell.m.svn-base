//
//  BSDetailOfTransferTableViewUserInfoCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/27.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSDetailOfTransferTableViewUserInfoCell.h"

static NSString * str = @"None";
#define LineSpacing 14.0f

@interface BSDetailOfTransferTableViewUserInfoCell ()


@property (nonatomic) UIButton * portraitBtn;
@property (nonatomic) UIImageView * portraitImgView;
@property (nonatomic) UILabel * nicknameLab;

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * contentLab;

@property (nonatomic) UIView * line;


@end

@implementation BSDetailOfTransferTableViewUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSDetailOfTransferTableViewUserInfoCellID";
    BSDetailOfTransferTableViewUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSDetailOfTransferTableViewUserInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self.contentView addSubview:self.portraitBtn];
    [self.contentView addSubview:self.portraitImgView];
    [self.contentView addSubview:self.nicknameLab];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.line];
    
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    [self.portraitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20.0f);
        make.top.equalTo(self).offset(30.0f);
        make.width.height.mas_equalTo(50.0f);
    }];
    
    [self.portraitImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.portraitBtn);
        make.size.equalTo(self.portraitBtn);
    }];
    
    [self.nicknameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.portraitBtn);
        make.left.mas_equalTo(self.portraitBtn.mas_right).offset(15.0f);
        make.right.mas_equalTo(self.mas_right).offset(-20.0f);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.portraitBtn.mas_bottom).offset(30.0f);
        make.left.equalTo(self.portraitBtn);
    }];
    
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(17.0f);
        make.left.equalTo(self.portraitBtn);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(100.0f);
        make.left.equalTo(self.portraitBtn);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    
    [self.portraitImgView bs_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:nil];;
    self.nicknameLab.text = model.nickname;
    self.titleLab.text = BSLocalizedString(@"description.of.transferring");
    
    self.contentLab.text = model.msg;
    [self.contentLab BS_setLineSpacingForAll:LineSpacing];
    [self layoutIfNeeded];
}


+ (CGFloat)heightForCellWithModel:(BSTradeModel *)model {
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];
    
    CGSize size = [model.msg BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 45, 9999) attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:titleFont}];
    
    
    CGFloat height = 146 + size.height + 30;
    
    return height;
}




- (void)portraitBtnClick {
//    [[BSConvenientOperationManager shareInstance] pushOthersController:[self getCurrentViewController] userID:self.model.uid];
}


- (UIButton *)portraitBtn {
    if (!_portraitBtn) {
        _portraitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _portraitBtn.adjustsImageWhenHighlighted = NO;
        [_portraitBtn addTarget:self action:@selector(portraitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _portraitBtn.layer.cornerRadius = 25 ;
        _portraitBtn.layer.masksToBounds = YES;
    }
    return _portraitBtn;
    
}


- (UIImageView *)portraitImgView {
    if (!_portraitImgView) {
        _portraitImgView                    = [[UIImageView alloc] init];
        _portraitImgView.layer.cornerRadius = 25 ;
        _portraitImgView.clipsToBounds      = YES;
        _portraitImgView.image              = [UIImage imageNamed:@"user_photo_normal"];
        _portraitImgView.contentMode        = UIViewContentModeScaleAspectFill;
        _portraitImgView.layer.borderWidth = 0.5;
        _portraitImgView.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
    }
    return _portraitImgView;
}

- (UILabel *)nicknameLab {
    if (!_nicknameLab) {
        _nicknameLab               = [[UILabel alloc] init];
        _nicknameLab.textColor     = BSCOLOR_000;
        _nicknameLab.font          = [UIFont systemFontOfSize:21.0f];
    }
    return _nicknameLab;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        _titleLab.textColor = BSCOLOR_000;
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:16.0f];
        _contentLab.textColor = BSCOLOR_000;
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

@end
