//
//  BSBusinessDetailTableViewContentCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSBusinessDetailTableViewContentCell.h"

@interface BSBusinessDetailTableViewContentCell ()


@property (nonatomic) UIButton * portraitBtn;
@property (nonatomic) UIImageView * portraitImgView;
@property (nonatomic) UILabel * nicknameLab;


//@property (nonatomic) UIView * contentBgView;
//@property (nonatomic) UIImageView * goodImgView;
//@property (nonatomic) UILabel * goodIntroLab;

@property (nonatomic) UIView * line;

@property (nonatomic) BSTradeModel * model;


@end

@implementation BSBusinessDetailTableViewContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSBusinessDetailTableViewContentCellID";
    BSBusinessDetailTableViewContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSBusinessDetailTableViewContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
//    [self.contentView addSubview:self.contentBgView];
//    [self.contentBgView addSubview:self.goodImgView];
//    [self.contentBgView addSubview:self.goodIntroLab];

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
    
//    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.portraitBtn.mas_bottom).offset(30.0f);
//        make.left.equalTo(self).offset(20.0f);
//        make.right.equalTo(self).offset(-20.0f);
//        make.height.mas_equalTo(90.0f);
//    }];
//
//    [self.goodImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.contentBgView);
//        make.left.equalTo(self.contentBgView).offset(15.0f);
//        make.width.height.mas_equalTo(60.0f);
//    }];
//
//    [self.goodIntroLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.contentBgView);
//        make.left.mas_equalTo(self.goodImgView.mas_right).offset(15.0f);
//        make.right.equalTo(self.contentBgView).offset(-15.0f);
//    }];
    

    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(100.0f);
        make.left.equalTo(self.portraitBtn);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    self.model = model;
    [self.portraitImgView bs_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:nil];
    self.nicknameLab.text = model.nickname;
 

   
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



//- (UIView *)contentBgView {
//    if (!_contentBgView) {
//        _contentBgView = [UIView new];
//        _contentBgView.backgroundColor = BSCOLOR_F3F3F3;
//    }
//    return _contentBgView;
//}
//
//- (UIImageView *)goodImgView {
//    if (!_goodImgView) {
//        _goodImgView = [UIImageView new];
//        _goodImgView.layer.borderWidth = 0.5;
//        _goodImgView.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
//    }
//    return _goodImgView;
//}
//
//- (UILabel *)goodIntroLab {
//    if (!_goodIntroLab) {
//        _goodIntroLab               = [[UILabel alloc] init];
//        _goodIntroLab.textColor     = BSCOLOR_4B4B4B;
//        _goodIntroLab.font          = [UIFont systemFontOfSize:12.0f];
//        _goodIntroLab.numberOfLines = 2;
//        _goodIntroLab.textAlignment = NSTextAlignmentLeft;
//    }
//    return _goodIntroLab;
//}


- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}



@end
