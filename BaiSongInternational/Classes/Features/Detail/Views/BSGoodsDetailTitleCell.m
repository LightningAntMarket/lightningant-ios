//
//  BSGoodsDetailTitleCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailTitleCell.h"
#import "BSUMSocialConfig.h"
#import "BSLoginManager.h"
#import "BSShareViewController.h"
@interface BSGoodsDetailTitleCell()

@property (strong , nonatomic) UILabel  *detailTitle;
@property (strong , nonatomic) UIButton *shareButton;

@property (strong , nonatomic) UILabel     *publishType;
@property (strong , nonatomic) UILabel     *publisherName;
@property (strong , nonatomic) UIImageView *publisherPhoto;

@property (strong , nonatomic) UIView  *line;

@end

@implementation BSGoodsDetailTitleCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailTitleCellID";
    BSGoodsDetailTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        
        [self.contentView addSubview:self.detailTitle];
        [self.contentView addSubview:self.shareButton];
        [self.contentView addSubview:self.publisherName];
        [self.contentView addSubview:self.publisherPhoto];
        [self.contentView addSubview:self.publishType];
        [self.contentView addSubview:self.line];

        [self.detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.contentView.mas_top).offset(27);
            make.right.equalTo(self.contentView).offset(-75);
        }];
        
        [self.publishType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.detailTitle.mas_bottom).offset(34);
        }];
        
        [self.publisherName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.publishType.mas_bottom).offset(17);
            make.right.equalTo(self.publisherPhoto.mas_left).offset(-3);

        }];
        
        [self.publisherPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.publishType.mas_top).offset(-3);
            make.width.equalTo(@50);
            make.height.equalTo(@50);

        }];
        
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@60);
            make.width.equalTo(@60);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self.publisherPhoto addGestureRecognizer:tapGesture];

    }
    return self;
}

+ (CGFloat)heightForCellWithModel:(BSGoods *)goods
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:9];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:21],
                                 NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize size = [goods.title BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 75 - 17, CGFLOAT_MAX) attributes:attributes];
    return size.height + 27.0f +108.0f;
}

- (void)setGoods:(BSGoods *)goods
{
    _goods = goods;
    
    self.detailTitle.text = goods.title;
    
    
    NSInteger pType = goods.modetype.integerValue;
    if (pType == 1) {
    }else if (pType == 2){
        self.publishType.text = BSLocalizedString(@"fixed.price");
    }else if (pType == 3){
        self.publishType.text = BSLocalizedString(@"auction");
    }
    
    self.publisherName.text =[NSString stringWithFormat:@"%@:%@",BSLocalizedString(@"seller"),goods.nickname];
    
    [self.publisherPhoto bs_setImageWithURL:[NSURL URLWithString:goods.face] placeholderImage:nil];
    
    [self.detailTitle BS_setLineSpacing:9];
    [self layoutIfNeeded];

}

- (void)shareButtonAction
{
    if (!self.goods.gid) {
        return;
    }
    NSString *linkURLString = [NSString stringWithFormat:@"%@/Home/Share/goods/gid/%@",BSDoMainURL,self.goods.gid];
//
//    BSShareViewController *shareVC = [[BSShareViewController alloc] initWithTitle:@"分享测试" image:self.goods.cover];
//    [[self getCurrentViewController] presentViewController:shareVC animated:YES completion:nil];
    
    [[BSUMSocialConfig shareInstance] showUMShareViewController:[self getCurrentViewController] title:self.goods.title content:self.goods.title imgURL:self.goods.cover LinkURL:linkURLString shareType:BSShareType_Normal resultHandler:^(id response) {

    }];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    UIViewController *currentVC = [self getCurrentViewController];
    
    if (![[BSLoginManager shareInstance] isLogin]) {
        [[BSLoginManager shareInstance] showLoginWithViewController:currentVC];
        return;
    }
    [[BSConvenientOperationManager shareInstance] pushOthersController:currentVC userID:self.goods.uid];
}

- (UILabel *)detailTitle
{
    if (!_detailTitle) {
        _detailTitle = [[UILabel alloc] init];
        _detailTitle.textColor = [UIColor blackColor];
        _detailTitle.font = [UIFont systemFontOfSize:21];
        _detailTitle.numberOfLines = 2;
    }
    return _detailTitle;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"goodsdetail_share"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

-(UIImageView *)publisherPhoto
{
    if (!_publisherPhoto) {
        _publisherPhoto = [[UIImageView alloc] init];
        _publisherPhoto.backgroundColor = BSCOLOR_F3F3F3;
        _publisherPhoto.contentMode = UIViewContentModeScaleAspectFill;
        _publisherPhoto.clipsToBounds = YES;
        _publisherPhoto.layer.cornerRadius = 25;
        _publisherPhoto.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _publisherPhoto.layer.borderWidth = 0.5;
        _publisherPhoto.userInteractionEnabled = YES;
    }
    return _publisherPhoto;
}

- (UILabel *)publisherName
{
    if (!_publisherName) {
        _publisherName = [[UILabel alloc] init];
        _publisherName.textColor = [UIColor colorWithHexString:@"a7a7a7"];
        _publisherName.font = [UIFont systemFontOfSize:14];
    }
    return _publisherName;
}

- (UILabel *)publishType
{
    if (!_publishType) {
        _publishType = [[UILabel alloc] init];
        _publishType.textColor = [UIColor colorWithHexString:@"a7a7a7"];
        _publishType.font = [UIFont systemFontOfSize:14];
    }
    return _publishType;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
