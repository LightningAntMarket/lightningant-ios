//
//  BSTaskPublishTableFooterCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/8.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishTableFooterCell.h"
@interface BSTaskPublishTableFooterCell ()
@property (nonatomic) UILabel *paymentNumLab;
@property (nonatomic) UIButton *payBtn;
@property (nonatomic) UILabel *tipLab1;
@property (nonatomic) UILabel *tipLab2;
@property (nonatomic) BSTaskPublishHelper *helper;
@end

@implementation BSTaskPublishTableFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskPublishTableFooterCellID";
    BSTaskPublishTableFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskPublishTableFooterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    [self.contentView addSubview:self.paymentNumLab];
    [self.contentView addSubview:self.payBtn];
    [self.contentView addSubview:self.tipLab1];
    [self.contentView addSubview:self.tipLab2];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    [self.paymentNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.paymentNumLab.mas_bottom).offset(20);
        make.width.mas_equalTo(200*BSScreen_Width/375);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    
    [self.tipLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payBtn.mas_bottom).offset(30);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
    }];

    [self.tipLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLab1.mas_bottom).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];

}

- (void)configCellWithPublishHelper:(BSTaskPublishHelper *)helper indexPath:(NSIndexPath *)indexPath {
    self.helper = helper;
    
    [self configCell];
}

- (void)setDelegate:(id<BSTaskPublishTableFooterCellDelegate>)delegate {
    if (!_delegate) {
        [self.helper.dataSource addObserver:self forKeyPath:NSStringFromSelector(@selector(price)) options:NSKeyValueObservingOptionNew context:nil];
        [self.helper.dataSource addObserver:self forKeyPath:NSStringFromSelector(@selector(prizeNum)) options:NSKeyValueObservingOptionNew context:nil];
    }
    _delegate = delegate;
    
    
}

-(void)dealloc {
//    if (self.delegate) {
        [self.helper.dataSource removeObserver:self forKeyPath:NSStringFromSelector(@selector(price))];
        [self.helper.dataSource removeObserver:self forKeyPath:NSStringFromSelector(@selector(prizeNum))];
//    }
    
}

- (void)payBtnClick {
    if ([self.delegate respondsToSelector:@selector(payBtnClick)]) {
        [self.delegate payBtnClick];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self configCell];
    
}

- (void)configCell {
    [self.helper checkPayBtnStatus];
    CGFloat paymentNum = [self.helper amountPaymentNumber];
    self.paymentNumLab.text = [NSString stringWithFormat:@"%@: %.2f LAP",BSLocalizedString(@"LN_localizable_2.0_46"),paymentNum];
    self.payBtn.alpha = self.helper.isPayBtnCanClick?1:0.5;
}

- (UILabel *)paymentNumLab {
    if (!_paymentNumLab) {
        _paymentNumLab = [UILabel new];
        _paymentNumLab.textColor = BSCOLOR_000;
        _paymentNumLab.font = [UIFont boldSystemFontOfSize:18];
    }
    return _paymentNumLab;
}

- (UILabel *)tipLab1 {
    if (!_tipLab1) {
        _tipLab1 = [UILabel new];
        _tipLab1.textColor = BSCOLOR_888;
        _tipLab1.font = [UIFont boldSystemFontOfSize:12];
        _tipLab1.text = BSLocalizedString(@"LN_localizable_2.0_48");
        _tipLab1.textAlignment = NSTextAlignmentCenter;
        _tipLab1.numberOfLines = 0;
    }
    return _tipLab1;
}

- (UILabel *)tipLab2 {
    if (!_tipLab2) {
        _tipLab2 = [UILabel new];
        _tipLab2.textColor = BSCOLOR_888;
        _tipLab2.font = [UIFont boldSystemFontOfSize:12];
        _tipLab2.text = BSLocalizedString(@"LN_localizable_2.0_49");
        _tipLab2.textAlignment = NSTextAlignmentCenter;
        _tipLab2.numberOfLines = 0;
    }
    return _tipLab2;
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [UIButton new];
        [_payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_payBtn setTitle:BSLocalizedString(@"LN_localizable_2.0_47") forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _payBtn.backgroundColor = BSCOLOR_337FDD;
        _payBtn.layer.cornerRadius = 20;
        _payBtn.layer.masksToBounds = YES;
    }
    return _payBtn;
}
@end
