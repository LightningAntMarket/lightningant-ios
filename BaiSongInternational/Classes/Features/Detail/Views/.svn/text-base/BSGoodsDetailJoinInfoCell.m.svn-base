//
//  BSGoodsDetailJoinInfoCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailJoinInfoCell.h"
#import "BSLoginManager.h"

@interface BSGoodsDetailJoinInfoCell ()

@property (strong , nonatomic) UIImageView *userPhoto;
@property (strong , nonatomic) UILabel     *userName;
@property (strong , nonatomic) UILabel     *time;
@property (strong , nonatomic) UILabel     *price;
//@property (strong , nonatomic) UIImageView *winerImage;

@end
@implementation BSGoodsDetailJoinInfoCell

+ (instancetype)cellForTableView:(UITableView *)tableView;
{
    static NSString * cellId = @"BSGoodsDetailJoinInfoCellID";
    BSGoodsDetailJoinInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailJoinInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.userPhoto];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.time];
//        [self.contentView addSubview:self.priceSymbol];
        
        [self.userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            
        }];

        
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(10);
            
        }];
        
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.userPhoto.mas_right).offset(15);
            make.right.equalTo(self.price.mas_left).offset(-3);
        }];
        
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
        }];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self.userPhoto addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)setJoinUser:(BSJoinUser *)joinUser
{
    _joinUser = joinUser;
    
    [self.userPhoto bs_setImageWithURL:[NSURL URLWithString:joinUser.face] placeholderImage:nil];
    self.userName.text = joinUser.nickname;
    self.price.text    = [@"LAP: " stringByAppendingString:joinUser.money];
    self.time.text = [joinUser.time timeInfoFromTimestamp];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    UIViewController *currentVC = [self getCurrentViewController];
    
    if (![[BSLoginManager shareInstance] isLogin]) {
        [[BSLoginManager shareInstance] showLoginWithViewController:currentVC];

        return;
    }
    [[BSConvenientOperationManager shareInstance] pushOthersController:currentVC userID:self.joinUser.uid];
}

#pragma mark - getter

- (UIImageView *)userPhoto
{
    if (!_userPhoto) {
        _userPhoto   = [[UIImageView alloc] init];
        _userPhoto.contentMode = UIViewContentModeScaleAspectFit;
        _userPhoto.backgroundColor = BSCOLOR_F3F3F3;
        _userPhoto.layer.masksToBounds = YES;
        _userPhoto.layer.cornerRadius = 20;
        _userPhoto.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _userPhoto.layer.borderWidth = 0.5;
        _userPhoto.userInteractionEnabled = YES;
        
    }
    return _userPhoto;
}

- (UILabel *)price
{
    if (!_price) {
        _price               = [[UILabel alloc] init];
        _price.font          = [UIFont systemFontOfSize:14];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.textColor     = [UIColor colorWithHexString:@"4b4b4b"];
    }
    return _price;
}


- (UILabel *)userName
{
    if (!_userName) {
        _userName               = [[UILabel alloc] init];
        _userName.font          = [UIFont systemFontOfSize:14];
        _userName.textColor     = [UIColor colorWithHexString:@"4b4b4b"];
        _userName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _userName;
}

- (UILabel *)time
{
    if (!_time) {
        _time               = [[UILabel alloc] init];
        _time.font          = [UIFont systemFontOfSize:12];
        _time.textColor     = [UIColor colorWithHexString:@"9b9b9b"];
    }
    return _time;
}
@end
