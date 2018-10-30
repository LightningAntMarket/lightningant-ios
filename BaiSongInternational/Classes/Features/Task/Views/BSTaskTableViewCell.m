//
//  BSTaskTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskTableViewCell.h"
#import "BSLoginManager.h"

@interface BSTaskTableViewCell()

@property (strong , nonatomic) UILabel     *taskTitle;
@property (strong , nonatomic) UIImageView *userPhoto;
@property (strong , nonatomic) UILabel     *userName;
@property (strong , nonatomic) UILabel     *label1;
@property (strong , nonatomic) UILabel     *label2;
@property (strong , nonatomic) UILabel     *label3;

@property (strong , nonatomic) UIView      *line;
@property (nonatomic) BSTaskModel * model;

@end

@implementation BSTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSTaskTableViewCellID";
    BSTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        
        [self.contentView addSubview:self.userPhoto];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.taskTitle];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label3];
        [self.contentView addSubview:self.line];
        
        [self.userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userPhoto.mas_right).offset(15);
            make.centerY.equalTo(self.userPhoto.mas_centerY);
        }];
        
        [self.taskTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.userPhoto.mas_bottom).offset(30);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.mas_equalTo(self.taskTitle.mas_bottom).offset(25);
            make.bottom.equalTo(self.contentView).offset(-30);
        }];
        
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.label1);
        }];
        
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(self.label1);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.contentView);
//            make.top.mas_equalTo(self.label1.mas_bottom).offset(30);
            make.height.equalTo(@0.5);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self.userPhoto addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    UIViewController *currentVC = [self getCurrentViewController];
    
    if (![[BSLoginManager shareInstance] isLogin]) {
        [[BSLoginManager shareInstance] showLoginWithViewController:currentVC];
        return;
    }
    [[BSConvenientOperationManager shareInstance] pushOthersController:currentVC userID:self.model.pub_id];
}
- (void)configCellWithModel:(BSTaskModel *)model indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        //订单页面
        self.line.hidden = NO;
    }else {
        //任务列表页面
        self.line.hidden = !indexPath.row;
    }
    if (![model isKindOfClass:[BSTaskModel class]]) {
        return;
    }
    self.model = model;
    [self.userPhoto bs_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:nil];
    self.userName.text = model.nickname;
    
    self.label1.text = [NSString stringWithFormat:@"%@%@ LAP",BSLocalizedString(@"LN_localizable_2.0_01"),model.wages];
    self.label2.text = [NSString stringWithFormat:@"%@%@",BSLocalizedString(@"LN_localizable_2.0_02"),model.accept_num];
    self.label3.text = [NSString stringWithFormat:@"%@%@/%@",BSLocalizedString(@"LN_localizable_2.0_04"),model.complete_num,model.total_num];
    
    self.taskTitle.text = model.describes;
    [self.taskTitle BS_setLineSpacingIfMoreThanOneLine:17];
}

- (UILabel *)taskTitle
{
    if (!_taskTitle) {
        _taskTitle = [[UILabel alloc] init];
        _taskTitle.textColor = [UIColor colorWithHexString:@"35353c"];
        _taskTitle.font = [UIFont systemFontOfSize:14];
        _taskTitle.numberOfLines = 2;
        
    }
    return _taskTitle;
}


-(UIImageView *)userPhoto
{
    if (!_userPhoto) {
        _userPhoto = [[UIImageView alloc] init];
        _userPhoto.backgroundColor = BSCOLOR_F3F3F3;
        _userPhoto.contentMode = UIViewContentModeScaleAspectFill;
        _userPhoto.clipsToBounds = YES;
        _userPhoto.layer.cornerRadius = 25;
        _userPhoto.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _userPhoto.layer.borderWidth = 0.5;
        _userPhoto.userInteractionEnabled = YES;
    }
    return _userPhoto;
}

- (UILabel *)userName
{
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.textColor = [UIColor colorWithHexString:@"35353c"];
        _userName.font = [UIFont systemFontOfSize:16];
    }
    return _userName;
}

- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.textColor = [UIColor colorWithHexString:@"888888"];
        _label1.font = [UIFont systemFontOfSize:12];
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.textColor = [UIColor colorWithHexString:@"888888"];
        _label2.font = [UIFont systemFontOfSize:12];
    }
    return _label2;
}

- (UILabel *)label3
{
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.textColor = [UIColor colorWithHexString:@"888888"];
        _label3.font = [UIFont systemFontOfSize:12];
    }
    return _label3;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}


@end
