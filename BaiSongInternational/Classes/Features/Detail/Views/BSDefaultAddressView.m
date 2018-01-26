//
//  BSDeliveryAddressView.m
//  YiBaiSong
//
//  Created by rjhx on 16/8/24.
//  Copyright © 2016年 yibaisong. All rights reserved.
//

#import "BSDefaultAddressView.h"


@implementation BSDefaultAddress

- (void)setAttributes:(NSDictionary *)jsonDic
{
    [super setAttributes:jsonDic];
    self.ID = [jsonDic objectForKey:@"id"];
}

@end

@interface BSDefaultAddressView()
@property (strong , nonatomic) BSDefaultAddress    *model;

@property (strong , nonatomic) UIButton    *dismissButton;
@property (strong , nonatomic) UIImageView *topImage;
@property (strong , nonatomic) UILabel     *hintLabel;
@property (strong , nonatomic) UIView      *addressBackground;
@property (strong , nonatomic) UILabel     *userName;
@property (strong , nonatomic) UILabel     *userPhone;
@property (strong , nonatomic) UILabel     *userAddress;
@property (strong , nonatomic) UIButton    *confirmButton;
@property (strong , nonatomic) UIButton    *cancelButton;


@end

@implementation BSDefaultAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius  = 5;
        self.layer.masksToBounds = YES;
        
        
        [self addSubview:self.dismissButton];
        [self addSubview:self.topImage];
        [self addSubview:self.hintLabel];
        [self addSubview:self.addressBackground];
        [self.addressBackground addSubview:self.userName];
        [self.addressBackground addSubview:self.userPhone];
        [self.addressBackground addSubview:self.userAddress];
        [self addSubview:self.confirmButton];
        [self addSubview:self.cancelButton];

        
        [self setupLayouts];
    }
    return self;
}
- (void)configureViewWithDic:(NSDictionary *)dic
{
    self.model = [[BSDefaultAddress alloc] initContentWithDic:dic];
    
    NSString *addressStr = [NSString stringWithFormat:@"[默认] %@%@",self.model.city,self.model.address];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:addressStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0f];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [addressStr length])];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"585c64"] range:NSMakeRange(0 , [addressStr length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BSCOLOR_337FDD range:NSMakeRange(0 , 4)];
    self.userAddress.attributedText = attributedString;
    
    
    self.userName.text = [NSString stringWithFormat:@"%@",self.model.consignee];
    self.userPhone.text = [NSString stringWithFormat:@"%@",self.model.phone];
}
#pragma mark - action

- (void)buttonAction:(UIButton *)button
{
    if (button.tag == 100) {
        //否
        if ([self.delegate respondsToSelector:@selector(addressView:didPressStatus:address:)]) {
            [self.delegate addressView:self didPressStatus:NO address:self.model];
        }
    }else if (button.tag == 101){
        //是
        if ([self.delegate respondsToSelector:@selector(addressView:didPressStatus:address:)]) {
            [self.delegate addressView:self didPressStatus:YES address:self.model];
        }
        
    }else if (button.tag == 102){
        //关闭
        
    }
    
    [self dismissAnimated:YES];
}
#pragma mark - layouts

- (void)setupLayouts {
    
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.centerX.equalTo(self);
        make.width.equalTo(@135);
        make.height.equalTo (@85);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImage.mas_bottom).offset(15);
        make.centerX.equalTo(self);
    }];
    
    [self.addressBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hintLabel.mas_bottom).offset(15);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@90);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.addressBackground.mas_top).offset(10);
        make.left.equalTo (self.addressBackground.mas_left).offset(10);
        make.width.equalTo(self.userPhone.mas_width);
    }];
    
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.addressBackground.mas_top).offset(10);
        make.right.equalTo(self.addressBackground.mas_right).offset(-10);
        make.left.equalTo (self.userName.mas_right).offset(10);
    }];
    
    //设置userName userPhone宽度的优先级 优先显示全userPhone；
    [self.userName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.userName setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.userPhone setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.userPhone setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [self.userAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressBackground.mas_left).offset(10);
        make.right.equalTo(self.addressBackground.mas_right).offset(-10);
        make.top.equalTo (self.userPhone.mas_bottom).offset(10);
        make.bottom.equalTo (self.addressBackground.mas_bottom).offset(-5);

    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@38);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.confirmButton.mas_left).offset(-25);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.equalTo(self.confirmButton.mas_width);

    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@38);
        make.left.equalTo(self.cancelButton.mas_right).offset(25);
        make.right.equalTo(self.mas_right).offset(-30);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.equalTo(self.cancelButton.mas_width);

    }];
    
}


#pragma mark - getter

-(UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.text = @"是否使用以下地址";
        _hintLabel.font = [UIFont systemFontOfSize:14];
        _hintLabel.textColor = [UIColor colorWithHexString:@"191919"];
    }
    return _hintLabel;
}

-(UIImageView *)topImage {
    if (!_topImage) {
        _topImage = [[UIImageView alloc] init];
        _topImage.image = [UIImage imageNamed:@"detail_address_bg"];
    }
    return _topImage;
}

-(UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [[UIButton alloc]init];
        [_dismissButton setImage:[UIImage imageNamed:@"detail_address_cancel"] forState:UIControlStateNormal];
        _dismissButton.tag = 102;
        [_dismissButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

-(UIView *)addressBackground {
    if (!_addressBackground) {
        _addressBackground = [[UIView alloc] init];
        _addressBackground.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    }
    return _addressBackground;
}

-(UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.textColor = [UIColor colorWithHexString:@"191919"];
        _userName.font = [UIFont systemFontOfSize:14];
        _userName.textAlignment = NSTextAlignmentLeft;
    }
    return _userName;
}

-(UILabel *)userPhone {
    if (!_userPhone) {
        _userPhone = [[UILabel alloc] init];
        _userPhone.textColor = [UIColor colorWithHexString:@"191919"];
        _userPhone.font = [UIFont systemFontOfSize:14];
        _userPhone.textAlignment = NSTextAlignmentRight;
    }
    return _userPhone;
}

-(UILabel *)userAddress {
    if (!_userAddress) {
        _userAddress = [[UILabel alloc] init];
        _userAddress.textColor = [UIColor colorWithHexString:@"585c64"];
        _userAddress.font = [UIFont systemFontOfSize:12];
        _userAddress.numberOfLines = 2;
    }
    return _userAddress;
}

-(UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"否" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"4b4b4b"] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        _cancelButton.layer.borderWidth = 0.5;
        _cancelButton.layer.borderColor = [UIColor colorWithHexString:@"eaeaea"].CGColor;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelButton.tag = 100;
        _cancelButton.layer.cornerRadius = 19;
        _cancelButton.layer.masksToBounds = YES;
        [_cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"是" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = BSCOLOR_337FDD;
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _confirmButton.tag = 101;
        _confirmButton.layer.cornerRadius = 19;
        _confirmButton.layer.masksToBounds = YES;
        [_confirmButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
