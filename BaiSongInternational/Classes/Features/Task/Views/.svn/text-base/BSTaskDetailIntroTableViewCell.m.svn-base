//
//  BSTaskDetailIntroTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailIntroTableViewCell.h"
#import "BSLoginManager.h"
#import "BSCommWebViewController.h"

@interface BSTaskDetailIntroTableViewCell()

@property (strong , nonatomic) UILabel     *taskTitle;
@property (strong , nonatomic) UIImageView *userPhoto;
@property (strong , nonatomic) UILabel     *userName;
@property (strong , nonatomic) UIButton    *linkBtn;
@property (strong , nonatomic) UIImageView *linkImgView;
@property (strong , nonatomic) UILabel     *linkLab;
@property (strong , nonatomic) UILabel     *label1;
@property (strong , nonatomic) UILabel     *label2;
@property (strong , nonatomic) UILabel     *label3;
@property (strong , nonatomic) UILabel     *label4;

@property (nonatomic) BSTaskModel * model;
@end

@implementation BSTaskDetailIntroTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskDetailIntroTableViewCellID";
    BSTaskDetailIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskDetailIntroTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {
    
    
    [self.contentView addSubview:self.userPhoto];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.taskTitle];
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
    [self.contentView addSubview:self.label3];
    [self.contentView addSubview:self.label4];
    
    [self.contentView addSubview:self.linkImgView];
    [self.contentView addSubview:self.linkLab];
    [self.contentView addSubview:self.linkBtn];

 
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.userPhoto addGestureRecognizer:tapGesture];
    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    [self.userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userPhoto.mas_right).offset(15);
        make.centerY.equalTo(self.userPhoto.mas_centerY);
    }];
    
    [self.taskTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.userPhoto.mas_bottom).offset(30);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [self.linkImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.taskTitle.mas_bottom).offset(30);
        make.width.mas_equalTo(18.5f);
        make.height.mas_equalTo(8);
    }];
    
    [self.linkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.linkImgView.mas_right).offset(15);
        make.centerY.equalTo(self.linkImgView);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [self.linkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.linkImgView);
        make.right.equalTo(self.linkLab);
        make.centerY.equalTo(self.linkImgView);
        make.height.mas_equalTo(30);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.linkImgView.mas_bottom).offset(30).priority(800);
        make.top.mas_equalTo(self.taskTitle.mas_bottom).offset(30).priority(700);
        make.right.mas_equalTo(self.label2.mas_left).offset(-20);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
//        make.width.mas_equalTo(100);
        make.centerY.equalTo(self.label1);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.label1);
        make.top.mas_equalTo(self.label1.mas_bottom).offset(17);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label2);
        make.centerY.equalTo(self.label3);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    
    [self.label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
}


- (void)configCellWithModel:(BSTaskModel *)model indexPath:(NSIndexPath *)indexPath {
    if (![model isKindOfClass:[BSTaskModel class]]) {
        return;
    }
    self.model = model;
    
    if (model.url.length == 0) {
        [self.linkImgView removeFromSuperview];
        [self.linkLab removeFromSuperview];
        [self.linkBtn removeFromSuperview];
    }
    
    [self.userPhoto bs_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:nil];
    self.userName.text = model.nickname;
    
    self.label1.text = [NSString stringWithFormat:@"%@%@ LAP",BSLocalizedString(@"LN_localizable_2.0_01"),model.wages];
    self.label2.text = [NSString stringWithFormat:@"%@%@",BSLocalizedString(@"LN_localizable_2.0_02"),model.accept_num];
    self.label3.text = [NSString stringWithFormat:@"%@%@",BSLocalizedString(@"LN_localizable_2.0_03"),[model.end_time timeYMDFromTimestamp]];
    self.label4.text = [NSString stringWithFormat:@"%@%@/%@",BSLocalizedString(@"LN_localizable_2.0_04"),model.complete_num,model.total_num];
    
    self.linkLab.text = model.url;
    
    self.taskTitle.text = model.describes;
    [self.taskTitle BS_setLineSpacingIfMoreThanOneLine:17];
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

- (void)linkBtnClick {
    BSCommWebViewController * webVC = [[BSCommWebViewController alloc]initWithURL:self.model.url];
    [[self getCurrentViewController].navigationController pushViewController:webVC animated:YES];
}

- (UILabel *)taskTitle
{
    if (!_taskTitle) {
        _taskTitle = [[UILabel alloc] init];
        _taskTitle.textColor = BSCOLOR_22262E;
        _taskTitle.font = [UIFont systemFontOfSize:14];
        _taskTitle.numberOfLines = 0;
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
        _userName.textColor = BSCOLOR_22262E;;
        _userName.font = [UIFont systemFontOfSize:16];
    }
    return _userName;
}

- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.textColor = [UIColor colorWithHexString:@"999999"];
        _label1.font = [UIFont systemFontOfSize:12];
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.textColor = [UIColor colorWithHexString:@"999999"];
        _label2.font = [UIFont systemFontOfSize:12];
  
    }
    return _label2;
}

- (UILabel *)label3
{
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.textColor = [UIColor colorWithHexString:@"999999"];
        _label3.font = [UIFont systemFontOfSize:12];
    }
    return _label3;
}

- (UILabel *)label4
{
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        _label4.textColor = [UIColor colorWithHexString:@"999999"];
        _label4.font = [UIFont systemFontOfSize:12];
    }
    return _label4;
}

- (UIButton *)linkBtn {
    if (!_linkBtn) {
        _linkBtn = [UIButton new];
        [_linkBtn addTarget:self action:@selector(linkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkBtn;
}

- (UIImageView *)linkImgView {
    if (!_linkImgView) {
        _linkImgView = [UIImageView new];
        _linkImgView.image = [UIImage imageNamed:@"task_link_icon.png"];
    }
    return _linkImgView;
}

- (UILabel *)linkLab
{
    if (!_linkLab) {
        _linkLab = [[UILabel alloc] init];
        _linkLab.textColor = BSCOLOR_337FDD;
        _linkLab.font = [UIFont systemFontOfSize:14];
    }
    return _linkLab;
}

@end
