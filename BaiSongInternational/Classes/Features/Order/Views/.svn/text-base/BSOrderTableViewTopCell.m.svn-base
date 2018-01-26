//
//  BSOrderTableViewTopCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderTableViewTopCell.h"

#import "BSOrderListSuperViewController.h"

@interface BSOrderTableViewTopCell ()
@property (nonatomic) UIButton * portraitBtn;
@property (nonatomic) UIImageView * portraitImgView;
@property (nonatomic) UILabel * nicknameLab;
@property (nonatomic) UILabel * statusLab;
@property (nonatomic) BSOrderModel * model;
@property (nonatomic) UIView * line;
@end

@implementation BSOrderTableViewTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderTableViewTopCellID";
    BSOrderTableViewTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderTableViewTopCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.statusLab];
    [self.contentView addSubview:self.line];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    [self.portraitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20.0f);
        make.top.equalTo(self).offset(40.0f);
        make.width.height.mas_equalTo(50.0f);
    }];
    
    [self.portraitImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.portraitBtn);
        make.size.equalTo(self.portraitBtn);
    }];
    
    [self.nicknameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.portraitBtn);
        make.left.mas_equalTo(self.portraitBtn.mas_right).offset(15.0f);
        make.right.mas_equalTo(self.mas_centerX).offset(-5.0f);
    }];
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.portraitBtn);
        make.right.equalTo(self).offset(-20.0f);
        make.left.mas_equalTo(self.mas_centerX).offset(5.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView {
    
    self.model = model;
    
    self.line.hidden = !indexPath.section;
    
    if (![model isKindOfClass:[BSOrderModel class]]) {
        return;
    }
    
    [self.portraitImgView bs_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:nil];
    self.nicknameLab.text = model.nickname;
    self.statusLab.text = model.orderStatus;
    
    
}

- (void)portraitBtnClick {
    
    
    [[BSConvenientOperationManager shareInstance] pushOthersController:[self getCurrentViewController] userID:self.model.uid];
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

- (UILabel *)statusLab {
    if (!_statusLab) {
        _statusLab               = [[UILabel alloc] init];
        _statusLab.textColor     = BSCOLOR_4B4B4B;
        _statusLab.font          = [UIFont systemFontOfSize:14.0f];
        _statusLab.numberOfLines = 2;
        _statusLab.textAlignment = NSTextAlignmentRight;
    }
    return _statusLab;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}


@end
