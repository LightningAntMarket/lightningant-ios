//
//  BSTradePayoutFirstSectionCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/22.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradePayoutFirstSectionCell.h"


#define Multiplied 0.35f

@interface BSTradePayoutFirstSectionCell ()

@property (nonatomic) UILabel * titleLab;

@property (nonatomic) UITextField * textField;

@property (nonatomic) UIView * line;

@property (nonatomic) BSTradeModel * model;
@property (nonatomic) NSIndexPath * indexPath;
@property (nonatomic) UITableView * talbeView;

@property (nonatomic) UIButton * bgBtn;
@end

@implementation BSTradePayoutFirstSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTradePayoutFirstSectionCellID";
    BSTradePayoutFirstSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTradePayoutFirstSectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.line];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {

    [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.equalTo(self.contentView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).multipliedBy(1 - Multiplied);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).multipliedBy(1 + Multiplied);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel *)model tableView:(UITableView *)tableView {

    self.model = model;
    self.indexPath = indexPath;
    self.talbeView = tableView;
    
    switch (indexPath.row) {
        case 0:
        {
            self.titleLab.text = BSLocalizedString(@"Address.for.withdraw.LAP");
            self.textField.placeholder = BSLocalizedString(@"Address.for.withdraw.LAP");
            self.textField.text = model.send_to;
            self.textField.keyboardType = UIKeyboardTypeDefault;
        }
            break;
            
        case 1:
        {
            self.titleLab.text = [NSString stringWithFormat:@"%@  LAP %@",BSLocalizedString(@"available.LAP"),self.model.balance];
            self.textField.placeholder = BSLocalizedString(@"amount.for.LAP.withdraw");
            self.textField.text = model.send_num;
            self.textField.keyboardType = UIKeyboardTypeDecimalPad;
        }
            break;
            
        default:
            break;
    }
    
}

-(void)passConTextChange:(UITextField *)textField{
    if (self.indexPath.row == 0) {
        self.model.send_to = textField.text;
    }else {
        self.model.send_num = textField.text;
    }
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
        _titleLab.textColor = BSCOLOR_000;
    }
    return _titleLab;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.textColor = BSCOLOR_4B4B4B;
        _textField.font = [UIFont systemFontOfSize:14.0f];
        [_textField addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

-(UIButton *)bgBtn {
    if (!_bgBtn) {
        _bgBtn = [UIButton new];
        [_bgBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}


- (void)bgBtnClick {
    [self.textField becomeFirstResponder];
}

@end
