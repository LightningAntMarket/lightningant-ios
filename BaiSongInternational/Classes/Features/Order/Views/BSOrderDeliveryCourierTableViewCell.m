//
//  BSOrderDeliveryCourierTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/15.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderDeliveryCourierTableViewCell.h"

@interface BSOrderDeliveryCourierTableViewCell ()<UITextFieldDelegate>
//点击cell、唤醒输入框
@property (nonatomic) UIButton * bgBtn;
@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UITextField * contentTextField;
@property (nonatomic) UIView * line;

@property (nonatomic) NSIndexPath * indexPath;
@property (nonatomic) BSOrderModel * model;
@end

@implementation BSOrderDeliveryCourierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderDeliveryCourierTableViewCellID";
    BSOrderDeliveryCourierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderDeliveryCourierTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.bgBtn];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentTextField];
    [self.contentView addSubview:self.line];
    
    [self layoutCustomView];
}


- (void)layoutCustomView {
    
    [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.equalTo(self.contentView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30.0f);
        make.left.equalTo(self.contentView).offset(20.0f);
        make.right.equalTo(self.contentView).offset(-20.0f);
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(17.0f);
        make.bottom.equalTo(self.line.mas_top).offset(-20.0);
        make.left.right.equalTo(self.titleLab);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.titleLab);
        make.height.mas_equalTo(0.5f);
    }];
    
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView{
    self.indexPath = indexPath;
    self.model = model;
    
    self.contentTextField.userInteractionEnabled = !model.isSended;
    
    if (indexPath.row == 1) {
        self.titleLab.text = BSLocalizedString(@"logistics.company");
        self.contentTextField.placeholder = BSLocalizedString(@"logistics.company");
        self.contentTextField.text = model.express_company;
    }else {
        self.titleLab.text = BSLocalizedString(@"tracking.number");
        self.contentTextField.placeholder = BSLocalizedString(@"tracking.number");
        self.contentTextField.text = model.express_number;
    }
}


-(void)passConTextChange:(UITextField *)textField{
    if (self.indexPath.row == 1) {
        self.model.express_company = textField.text;
    }else {
        self.model.express_number = textField.text;
    }
}

- (void)bgBtnClick {
    [self.contentTextField becomeFirstResponder];
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_4B4B4B;
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _titleLab;
}

- (UITextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [UITextField new];
        _contentTextField.textColor = BSCOLOR_4B4B4B;
        _contentTextField.font = [UIFont systemFontOfSize:14.0f];
        [_contentTextField addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];

    }
    return _contentTextField;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

- (UIButton *)bgBtn {
    if (!_bgBtn) {
        _bgBtn = [UIButton new];
        [_bgBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}
@end
