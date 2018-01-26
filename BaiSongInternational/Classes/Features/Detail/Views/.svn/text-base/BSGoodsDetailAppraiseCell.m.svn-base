//
//  BSGoodsDetailAppraiseCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/12/18.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailAppraiseCell.h"
#import "BSGoodsDetailModel.h"

@interface BSGoodsDetailAppraiseCell()

@property (strong , nonatomic) UIImageView *scoreBgImage;
@property (strong , nonatomic) UILabel     *scoreLabel;

@property (strong , nonatomic) UIImageView *starsImage;
@property (strong , nonatomic) UILabel     *appraiseTitle;
@property (strong , nonatomic) UIView      *line;

@end

@implementation BSGoodsDetailAppraiseCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailAppraiseCellID";
    BSGoodsDetailAppraiseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailAppraiseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        [self.contentView addSubview:self.appraiseTitle];
        [self.contentView addSubview:self.starsImage];
        [self.contentView addSubview:self.scoreBgImage];
        [self.scoreBgImage addSubview:self.scoreLabel];

        [self.contentView addSubview:self.line];
        
        [self.appraiseTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.scoreBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.appraiseTitle.mas_right).offset(10);
            make.centerY.equalTo(self.appraiseTitle.mas_centerY);
        }];
        
        [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scoreBgImage);
        }];
        
        [self.starsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@17);
            make.width.equalTo(@17);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
    }
    return self;
}

- (void)setDetailModel:(BSGoodsDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    self.scoreLabel.text = detailModel.score;
}

- (UIImageView *)scoreBgImage
{
    if (!_scoreBgImage) {
        _scoreBgImage               = [[UIImageView alloc] init];
        _scoreBgImage.contentMode = UIViewContentModeScaleAspectFit;
        _scoreBgImage.image = [UIImage imageNamed:@"goods_detail_score"];
    }
    return _scoreBgImage;
}

- (UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font          = [UIFont boldSystemFontOfSize:12];
//        _scoreLabel.text          = @"4.5";
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.textColor     = [UIColor whiteColor];
    }
    return _scoreLabel;
}

- (UIImageView *)starsImage
{
    if (!_starsImage) {
        _starsImage               = [[UIImageView alloc] init];
        _starsImage.contentMode = UIViewContentModeScaleAspectFit;
        _starsImage.image = [UIImage imageNamed:@"goods_detail_stars"];
    }
    return _starsImage;
}

- (UILabel *)appraiseTitle
{
    if (!_appraiseTitle) {
        _appraiseTitle               = [[UILabel alloc] init];
        _appraiseTitle.font          = [UIFont boldSystemFontOfSize:16];
        _appraiseTitle.text          = BSLocalizedString(@"read.all.comments");
        _appraiseTitle.textColor     = BSCOLOR_4B4B4B;
    }
    return _appraiseTitle;
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
