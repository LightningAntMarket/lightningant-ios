//
//  BSGoodsDetailPriceBottomView.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/8.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailPriceBottomView.h"

@interface BSGoodsDetailPriceBottomView()<UITextFieldDelegate>

@property (strong , nonatomic) UILabel *currentPrice;//当前出价
@property (strong , nonatomic) UILabel *myFund;//我的资产
@property (strong , nonatomic) UIView *line;

@property (strong , nonatomic) UIButton *decreaseButton;
@property (strong , nonatomic) UIButton *addButton;

@property (strong , nonatomic) UITextField *priceTextField;

@property (strong , nonatomic) UIButton *addButton_10;
@property (strong , nonatomic) UIButton *addButton_50;
@property (strong , nonatomic) UIButton *addButton_100;

@property (strong , nonatomic) UIButton *finishButton;

@end

@implementation BSGoodsDetailPriceBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BSCOLOR_F3F3F3;
        
        [self addSubview:self.currentPrice];
        [self addSubview:self.myFund];
        [self addSubview:self.line];
        [self addSubview:self.decreaseButton];
        [self addSubview:self.addButton];
        [self addSubview:self.priceTextField];
        [self addSubview:self.addButton_100];
        [self addSubview:self.addButton_50];
        [self addSubview:self.addButton_10];
        [self addSubview:self.finishButton];

        [self layoutViews];
        
        [self.priceTextField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];

    }
    return self;
}

- (void)dismiss
{
    if ([self.priceTextField isFirstResponder]) {
        [self.priceTextField resignFirstResponder];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.frame =  CGRectMake(0, BSScreen_Height, BSScreen_Width, PriceViewDefaultHeight);
        }];
    }
}

- (void)showView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =  CGRectMake(0, BSScreen_Height - PriceViewDefaultHeight, BSScreen_Width, PriceViewDefaultHeight);
    }];
}

- (void)setDetailModel:(BSGoodsDetailModel *)detailModel
{
    _detailModel = detailModel;
    self.priceTextField.text = [NSString stringWithFormat:@"%.2f",detailModel.goods.price.floatValue + 1];
    self.currentPrice.text   = [NSString stringWithFormat:@"当前价格：%@",detailModel.goods.price];
    self.myFund.text         = [NSString stringWithFormat:@"钱包LAP：%@",detailModel.myBalance];
}

- (void)decreaseButtonAction
{
    //减
    self.priceTextField.text = [NSString stringWithFormat:@"%d",self.priceTextField.text.intValue - 1];
}

- (void)addButtonAction
{
    //加
    self.priceTextField.text = [NSString stringWithFormat:@"%d",self.priceTextField.text.intValue + 1];
}

- (void)addButton10Action
{
    //+10
    self.priceTextField.text = [NSString stringWithFormat:@"%d",self.priceTextField.text.intValue + 10];
    
}

- (void)addButton50Action
{
    //+50
    self.priceTextField.text = [NSString stringWithFormat:@"%d",self.priceTextField.text.intValue + 50];
}

- (void)addButton100Action
{
    //+100
    self.priceTextField.text = [NSString stringWithFormat:@"%d",self.priceTextField.text.intValue + 100];
}

- (void)finishButtonAction
{
    if ([self.delegate respondsToSelector:@selector(priceView:buyGoodsWithPrice:)]) {
        [self.delegate priceView:self buyGoodsWithPrice:self.priceTextField.text];
    }
}

/**监听*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"text"]){
        
//        if (self.inputText.text.intValue <= self.currentMax.intValue + 1) {
//            self.minusBtn.selected = YES;
//        }else{
//            self.minusBtn.selected = NO;
//            
//        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text
{
    //禁止换行
    if ([text isEqualToString:@"\n"]){
        //收起键盘
        [textField resignFirstResponder];
        return NO;
    }
    
    NSString *aString = [textField.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([text isEmoji]) {
        return NO;
    }
    
    //输入的价格
    
    //只能输入0～9 .
    if (text.length) {
        unichar single = [text characterAtIndex:0];
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            return NO;
        }
    }
    
    //.
    if ([aString isEqualToString:@"."]) {
        textField.text = @"0";
    }
    //不能出现多个.
    if ([textField.text containsString:@"."] && [text isEqualToString:@"."]) {
        return NO;
    }
    //小数点只能是两位
    if ([textField.text containsString:@"."]) {
        NSRange pointRange = [textField.text rangeOfString:@"."];
        if (range.location > pointRange.location + 2) {
            return NO;
            
        }
    }
    //最多8位整数
    if (aString.length > 8 && ![textField.text containsString:@"."]) {
        return NO;
    }
    
    return YES;
}

- (void)dealloc
{
    [self.priceTextField removeObserver:self forKeyPath:@"text"];
}


- (void)layoutViews
{
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(BSScreen_Width/2));
        make.height.equalTo(@(50));
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        
    }];
    
    [self.myFund mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(BSScreen_Width/2));
        make.height.equalTo(@(50));
        make.left.equalTo(self.currentPrice.mas_right);
        make.top.equalTo(self.mas_top);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(20));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(15);
        
    }];
    
    [self.priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.left.equalTo(self.mas_left).offset(65);
        make.right.equalTo(self.mas_right).offset(-65);
        make.top.equalTo(self.currentPrice.mas_bottom).offset(30);
        
    }];
    
    [self.decreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(32));
        make.width.equalTo(@(32));
        make.right.equalTo(self.priceTextField.mas_left).offset(-17);
        make.centerY.equalTo(self.priceTextField.mas_centerY);
        
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(32));
        make.width.equalTo(@(32));
        make.left.equalTo(self.priceTextField.mas_right).offset(17);
        make.centerY.equalTo(self.priceTextField.mas_centerY);
        
    }];
    
    [self.addButton_10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.width.equalTo(@(90));
        make.left.equalTo(self.decreaseButton.mas_left);
        make.top.equalTo(self.priceTextField.mas_bottom).offset(30);
        
    }];
    
    [self.addButton_50 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.width.equalTo(@(90));
        make.top.equalTo(self.priceTextField.mas_bottom).offset(30);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    [self.addButton_100 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.width.equalTo(@(90));
        make.right.equalTo(self.addButton.mas_right);
        make.top.equalTo(self.priceTextField.mas_bottom).offset(30);
        
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.right.equalTo(self.addButton.mas_right);
        make.left.equalTo(self.decreaseButton.mas_left);
        make.top.equalTo(self.addButton_50.mas_bottom).offset(40);
        
    }];
}


-(UILabel *)currentPrice
{
    if (!_currentPrice) {
        _currentPrice = [[UILabel alloc] init];
        _currentPrice.backgroundColor = [UIColor whiteColor];
        _currentPrice.textColor = BSCOLOR_4B4B4B;
        _currentPrice.font = [UIFont systemFontOfSize:14];
        _currentPrice.textAlignment = NSTextAlignmentCenter;
    }
    return _currentPrice;
}

-(UILabel *)myFund
{
    if (!_myFund) {
        _myFund = [[UILabel alloc] init];
        _myFund.backgroundColor = [UIColor whiteColor];
        _myFund.textColor = BSCOLOR_4B4B4B;
        _myFund.font = [UIFont systemFontOfSize:14];
        _myFund.textAlignment = NSTextAlignmentCenter;

    }
    return _myFund;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

- (UIButton *)decreaseButton
{
    if (!_decreaseButton) {
        _decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _decreaseButton.backgroundColor = [UIColor clearColor];
        [_decreaseButton setImage:[UIImage imageNamed:@"goods_detail_decrease"] forState:UIControlStateNormal];
        [_decreaseButton addTarget:self action:@selector(decreaseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _decreaseButton;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor clearColor];
        [_addButton setImage:[UIImage imageNamed:@"goods_detail_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];


    }
    return _addButton;
}

- (UITextField *)priceTextField
{
    if (!_priceTextField) {
        _priceTextField = [[UITextField alloc] init];
        _priceTextField.backgroundColor = [UIColor whiteColor];
        _priceTextField.borderStyle = UITextBorderStyleNone;
        _priceTextField.textAlignment = NSTextAlignmentCenter;
        _priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _priceTextField.font = [UIFont systemFontOfSize:16];
        _priceTextField.textColor = BSCOLOR_4B4B4B;
        _priceTextField.delegate = self;

    }
    return _priceTextField;
}

- (UIButton *)addButton_10
{
    if (!_addButton_10) {
        _addButton_10 = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton_10.backgroundColor = [UIColor colorWithHexString:@"d8dadd"];
        _addButton_10.layer.cornerRadius  = 15;
        _addButton_10.layer.masksToBounds = YES;
//        _addButton_10.layer.borderColor = [UIColor colorWithHexString:@"b6ceec"].CGColor;
//        _addButton_10.layer.borderWidth = 1.5;
        _addButton_10.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addButton_10 setTitleColor:BSCOLOR_4B4B4B forState:UIControlStateNormal];
        [_addButton_10 setTitle:@"+10" forState:UIControlStateNormal];
        [_addButton_10 addTarget:self action:@selector(addButton10Action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton_10;
}

- (UIButton *)addButton_50
{
    if (!_addButton_50) {
        _addButton_50 = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton_50.backgroundColor = [UIColor colorWithHexString:@"d8dadd"];
        _addButton_50.layer.cornerRadius  = 15;
        _addButton_50.layer.masksToBounds = YES;
        _addButton_50.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addButton_50 setTitle:@"+50" forState:UIControlStateNormal];
        [_addButton_50 setTitleColor:BSCOLOR_4B4B4B forState:UIControlStateNormal];
        [_addButton_50 addTarget:self action:@selector(addButton50Action) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addButton_50;
}

- (UIButton *)addButton_100
{
    if (!_addButton_100) {
        _addButton_100 = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton_100.backgroundColor = [UIColor colorWithHexString:@"d8dadd"];
        _addButton_100.layer.cornerRadius  = 15;
        _addButton_100.layer.masksToBounds = YES;
        _addButton_100.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addButton_100 setTitle:@"+100" forState:UIControlStateNormal];
        [_addButton_100 setTitleColor:BSCOLOR_4B4B4B forState:UIControlStateNormal];
        [_addButton_100 addTarget:self action:@selector(addButton100Action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton_100;
}

- (UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishButton.backgroundColor = [UIColor colorWithHexString:@"337fdd"];
        _finishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_finishButton setTitle:@"立即出价" forState:UIControlStateNormal];
        _finishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _finishButton.layer.cornerRadius  = 20;
        _finishButton.layer.masksToBounds = YES;
        [_finishButton addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _finishButton;
}

@end
