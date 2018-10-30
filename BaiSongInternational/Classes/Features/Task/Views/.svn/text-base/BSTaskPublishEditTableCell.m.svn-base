//
//  BSTaskPublishEditTableCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishEditTableCell.h"
#import "UITextField+Extend.h"


@interface BSTaskPublishEditTableCell ()<UITextFieldDelegate>
@property (nonatomic) UITextField * textField;
@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * contentLab;
@property (nonatomic) UIImageView * iconImgView;

@property (nonatomic) NSIndexPath * indexPath;

@property (nonatomic) NSArray <NSString *> * titleArr;

@property (nonatomic) NSArray <NSString *> * contentArr;

@property (nonatomic) BSTaskPublishHelper * publishHelper;

@property (nonatomic) NSArray<NSMutableIndexSet *> * cellRowIndexSet;
@end

@implementation BSTaskPublishEditTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskPublishEditTableCellID";
    BSTaskPublishEditTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskPublishEditTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.iconImgView];
    [self layoutCustomViews];
    

    self.textField.placeholder = BSLocalizedString(@"LN_localizable_2.0_39");
    
}


- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(60).priority(500);
        make.width.mas_equalTo(130);
    }];
    
    [self.titleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_equalTo(self.titleLab.mas_right).offset(30);
        
        //第一顺位
        make.right.mas_equalTo(self.contentLab.mas_left).offset(-3).priority(800);
        //第二顺位
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20).priority(750);
    
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        
        //第一顺位
        make.right.mas_equalTo(self.iconImgView.mas_left).offset(-5).priority(800);
        //第二顺位
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20).priority(750);
    }];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(7);
    }];
}


- (void)configCellWithPublishHelper:(BSTaskPublishHelper *)publishHelper indexPath:(NSIndexPath *)indexPath {

    self.publishHelper = publishHelper;
    [self checkNeedLayoutWithIndexPath:indexPath];
    self.indexPath = indexPath;

    
    
    self.titleLab.text = self.titleArr[indexPath.row];
    self.contentLab.text = self.contentArr[indexPath.row];
    
    if (indexPath.row == 1 || indexPath.row == 2) {
        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    }else if(indexPath.row == 5){
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            if (publishHelper.dataSource.desc.length) {
                self.contentLab.text = publishHelper.dataSource.desc;
            }
            
        }
            break;
        case 1:
        {
            if (publishHelper.dataSource.price.length) {
                self.textField.text = publishHelper.dataSource.price;
            }
        }
            break;
        case 2:
        {
            if (publishHelper.dataSource.prizeNum.length) {
                self.textField.text = publishHelper.dataSource.prizeNum;
            }
        }
            break;
        case 3:
        {
            if (publishHelper.dataSource.overTime.length) {
                self.contentLab.text = publishHelper.dataSource.overTime;
            }
        }
            break;
        case 4:
        {
            if (publishHelper.dataSource.Link.length) {
                self.contentLab.text = publishHelper.dataSource.Link;
            }
        }
            break;
        case 5:
        {
            if (publishHelper.dataSource.guideArr.count) {
                self.contentLab.text = [NSString stringWithFormat:BSLocalizedString(@"LN_localizable_2.0_122"),publishHelper.dataSource.guideArr.count];
            }
        }
            break;
            
            
        default:
            break;
    }
}

- (void)checkNeedLayoutWithIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.indexPath) {
        self.indexPath = indexPath;
        [self reLayoutCustomViews];
    }
    
    if ([self.cellRowIndexSet[0] containsIndex:self.indexPath.row] && [self.cellRowIndexSet[0] containsIndex:indexPath.row]) {
        
        return;
    }
    
    if ([self.cellRowIndexSet[1] containsIndex:self.indexPath.row] && [self.cellRowIndexSet[1] containsIndex:indexPath.row]) {
        
        return;
    }
    
    if ([self.cellRowIndexSet[2] containsIndex:self.indexPath.row] && [self.cellRowIndexSet[2] containsIndex:indexPath.row]) {
        
        return;
    }
    
    self.indexPath = indexPath;
    [self reLayoutCustomViews];
}

- (void)reLayoutCustomViews {
    
    
    
    [self setNeedsLayout];
    
    if ([self.cellRowIndexSet[0] containsIndex:self.indexPath.row]) {
        self.iconImgView.hidden = NO;
        self.contentLab.hidden = NO;
        self.textField.hidden = YES;
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            
            //第一顺位
            make.left.mas_equalTo(self.titleLab.mas_right).offset(30); make.right.mas_equalTo(self.iconImgView.mas_left).offset(-5);
            
        }];
        
        [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(8);
            make.width.mas_equalTo(7);
        }];
        
    }
    
    
    if ([self.cellRowIndexSet[1] containsIndex:self.indexPath.row]) {
        
        self.iconImgView.hidden = YES;
        self.contentLab.hidden = NO;
        self.textField.hidden = NO;
        
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(30);
            make.right.mas_equalTo(self.contentLab.mas_left).offset(-3);
            make.height.equalTo(self.contentView);
            
        }];
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        }];
    }
    
    
    if ([self.cellRowIndexSet[2] containsIndex:self.indexPath.row]) {
        
        
        self.iconImgView.hidden = YES;
        self.contentLab.hidden = YES;
        self.textField.hidden = NO;
        
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(30);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        }];
        
    }
    
    

    [self layoutIfNeeded];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if (self.indexPath.row == 1) {
        //单次酬金
        if (![textField validateNumberDot:string range:range count:2]) {
            return NO;
            
        }
        if (![textField validateNumberDot:string range:range MaxNumber:self.publishHelper.priceMaxNum]) {
            textField.text = [NSString stringWithFormat:@"%.2f",self.publishHelper.priceMaxNum];
            [self textFieldDidChange:textField];
            return NO;
        }
        
    }else if (self.indexPath.row == 2) {
        //奖励份数
        
        if (![textField validateNumberDot:string range:range count:0]) {
            return NO;
            
        }
        
        if (![textField validateNumberDot:string range:range MaxNumber:self.publishHelper.prizeMaxNum]) {
            textField.text = [NSString stringWithFormat:@"%.0f",self.publishHelper.prizeMaxNum];
            [self textFieldDidChange:textField];
            return NO;
        }
    }else if (self.indexPath.row ==4 ) {
//        if(![textField validateSpacing:string range:range]) {
//            return NO;
//        }
//        if ([string isEmoji]) {
//            return NO;
//        }
    }
    
    return YES;
}


-(void)textFieldDidChange:(UITextField *)textField{
    if (self.indexPath.row == 1) {
        self.publishHelper.dataSource.price = textField.text;
    }else if (self.indexPath.row == 2) {
        self.publishHelper.dataSource.prizeNum = textField.text;
    }else if (self.indexPath.row == 4) {
        self.publishHelper.dataSource.Link = textField.text;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.indexPath.row == 1) {
        if ([textField.text floatValue] < 1) {
            self.textField.text = @"1";
            self.publishHelper.dataSource.price = textField.text;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField endEditing:YES];
    return YES;
}

#pragma mark - setter && getter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = BSCOLOR_4B4B4B;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = BSCOLOR_000;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}

-(UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.textColor = BSCOLOR_000;
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.textAlignment = NSTextAlignmentRight;
    }
    return _contentLab;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"task_publish_edit.png"];
    }
    return _iconImgView;
}

-(NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[BSLocalizedString(@"LN_localizable_2.0_37"),BSLocalizedString(@"LN_localizable_2.0_38"),BSLocalizedString(@"LN_localizable_2.0_40"),BSLocalizedString(@"LN_localizable_2.0_42"),BSLocalizedString(@"LN_localizable_2.0_43"),BSLocalizedString(@"LN_localizable_2.0_44")];
    }
    return _titleArr;
}

- (NSArray<NSString *> *)contentArr {
    if (!_contentArr) {
        _contentArr = @[BSLocalizedString(@"LN_localizable_2.0_39"),BSLocalizedString(@"/ LAP"),[NSString stringWithFormat:@"/%@",BSLocalizedString(@"LN_localizable_2.0_41")],BSLocalizedString(@"time_transaction_34"),BSLocalizedString(@""),BSLocalizedString(@"LN_localizable_2.0_123")];
    }
    return _contentArr;
}

- (NSArray<NSMutableIndexSet *> *)cellRowIndexSet {
    if (!_cellRowIndexSet) {
        NSMutableIndexSet * set1 = [[NSMutableIndexSet alloc]init];
        [set1 addIndex:0];
        [set1 addIndex:3];
        [set1 addIndex:5];
        
        NSMutableIndexSet * set2 = [[NSMutableIndexSet alloc]init];
        [set2 addIndex:1];
        [set2 addIndex:2];
    
        NSMutableIndexSet * set3 = [[NSMutableIndexSet alloc]init];
        [set3 addIndex:4];
        
        _cellRowIndexSet = @[set1,set2,set3];
        
    }
    return _cellRowIndexSet;
}
@end
