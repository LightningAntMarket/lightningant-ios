//
//  BSGoodsDetailRecordCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/10/27.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailRecordCell.h"
#import "BSLoginManager.h"

@interface BSGoodsDetailRecordCell()

@property (strong , nonatomic) UIImageView *participatorPhoto;
@property (strong , nonatomic) UILabel     *participatorName;
@property (strong , nonatomic) UILabel     *participatorTime;
@property (strong , nonatomic) UILabel     *priceRecord;
@property (strong , nonatomic) UIView  *line;
@end

@implementation BSGoodsDetailRecordCell

+ (instancetype)cellForTableView:(UITableView *)tableView;
{
    static NSString * cellId = @"BSGoodsDetailRecordCellID";
    BSGoodsDetailRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailRecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.participatorPhoto];
        [self.contentView addSubview:self.participatorName];
        [self.contentView addSubview:self.priceRecord];
        [self.contentView addSubview:self.participatorTime];
        [self.contentView addSubview:self.line];
        
        [self.participatorPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@34);
            make.width.equalTo(@34);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            
        }];
        
        [self.priceRecord mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(10);
        }];

        [self.participatorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.participatorPhoto.mas_right).offset(10);
            make.right.equalTo(self.priceRecord.mas_left).offset(-3);
        }];
        
        [self.participatorTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self.participatorPhoto addGestureRecognizer:tapGesture];

        
    }
    return self;
}

- (void)setJoinUser:(BSJoinUser *)joinUser
{
    _joinUser = joinUser;
    
    [self.participatorPhoto bs_setImageWithURL:[NSURL URLWithString:joinUser.face] placeholderImage:nil];

    self.participatorName.text = joinUser.nickname;
    self.participatorTime.text = [joinUser.time timeInfoFromTimestamp];
    self.priceRecord.text      = [NSString stringWithFormat:@"%@ LAP",joinUser.money];
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
- (UIImageView *)participatorPhoto
{
    if (!_participatorPhoto) {
        _participatorPhoto   = [[UIImageView alloc] init];
        _participatorPhoto.contentMode     = UIViewContentModeScaleAspectFit;
        _participatorPhoto.backgroundColor = BSCOLOR_F3F3F3;
        _participatorPhoto.layer.masksToBounds = YES;
        _participatorPhoto.layer.cornerRadius  = 17;
        _participatorPhoto.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _participatorPhoto.layer.borderWidth = 0.5;
        _participatorPhoto.userInteractionEnabled = YES;
    }
    return _participatorPhoto;
}

- (UILabel *)priceRecord
{
    if (!_priceRecord) {
        _priceRecord               = [[UILabel alloc] init];
        _priceRecord.font          = [UIFont systemFontOfSize:14];
        _priceRecord.textAlignment = NSTextAlignmentCenter;
        _priceRecord.textColor     = BSCOLOR_4B4B4B;
    }
    return _priceRecord;
}

- (UILabel *)participatorName
{
    if (!_participatorName) {
        _participatorName               = [[UILabel alloc] init];
        _participatorName.font          = [UIFont systemFontOfSize:14];
        _participatorName.textColor     = BSCOLOR_4B4B4B;
        _participatorName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _participatorName;
}

- (UILabel *)participatorTime
{
    if (!_participatorTime) {
        _participatorTime               = [[UILabel alloc] init];
        _participatorTime.font          = [UIFont systemFontOfSize:12];
        _participatorTime.textColor     = [UIColor colorWithHexString:@"9b9b9b"];
    }
    return _participatorTime;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    }
    return _line;
}
@end
