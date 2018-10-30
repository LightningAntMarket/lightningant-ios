//
//  BSTaskPublishDescribeTableInputCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishDescribeTableInputCell.h"
#import "BSPlaceholderTextView.h"


@interface BSTaskPublishDescribeTableInputCell ()<UITextViewDelegate>

@property (nonatomic) UIView *bgView;
@property (nonatomic) BSPlaceholderTextView *textView;

@property (nonatomic) BSTaskPublishHelper * publishHelper;

@end

@implementation BSTaskPublishDescribeTableInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskPublishDescribeTableInputCellID";
    BSTaskPublishDescribeTableInputCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskPublishDescribeTableInputCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.textView];
    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 20, 10, 20));
        make.height.mas_equalTo(230);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView).insets(UIEdgeInsetsMake(15, 15, 15, 15));
        
    }];
    
}


- (void)configCellWithPublishHelper:(BSTaskPublishHelper *)publishHelper indexPath:(NSIndexPath *)indexPath {
    self.publishHelper = publishHelper;
    self.textView.text = publishHelper.dataSource.desc;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(didInputDescWithTextView:)]) {
        [self.delegate didInputDescWithTextView:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSString *aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (aString.length > self.publishHelper.descMaxCount) {
        return NO;
    }
    return YES;
}


- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.layer.borderColor = [UIColor colorWithHexString:@"eaeaea"].CGColor;
        _bgView.layer.borderWidth = 0.5;
    }
    return _bgView;
}

- (BSPlaceholderTextView *)textView {
    if (!_textView) {
        _textView = [BSPlaceholderTextView new];
        _textView.textColor = BSCOLOR_4B4B4B;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.delegate = self;
    }
    return _textView;
}
@end
