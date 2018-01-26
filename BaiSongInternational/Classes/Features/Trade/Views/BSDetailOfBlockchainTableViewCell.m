//
//  BSDetailOfBlockchainTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSDetailOfBlockchainTableViewCell.h"
#import "UILabel+Extend.h"

@interface BSDetailOfBlockchainTableViewCell ()

@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UILabel * contentLab;

@end


#define LineSpacing 14.0f

@implementation BSDetailOfBlockchainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSDetailOfBlockchainTableViewCellID";
    BSDetailOfBlockchainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSDetailOfBlockchainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-40.0f);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
    }];
}


- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSTradeModel * )model tableView:(UITableView *)tableView {
    
    
    NSString * str;
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                self.titleLab.text = BSLocalizedString(@"address.of.the.receiver");
                str = model.myaddresses;
            }
            
            if (indexPath.row == 1) {
                self.titleLab.text = BSLocalizedString(@"address.of.the.sender");
                str = model.addresses;
            }
        }
            break;
            
            
        case 1:
        {
            if (indexPath.row == 0) {
                self.titleLab.text = BSLocalizedString(@"transaction.number");
                str = model.txid;
            }
            
            
            if (indexPath.row == 1) {
                self.titleLab.text = BSLocalizedString(@"transaction.time");
                str = [model.time timeYMDFromTimestamp];
            }
        }
            break;
        default:
            break;
    }
    
    
    
    self.contentLab.text = str;
    [self.contentLab BS_setLineSpacingForAll:LineSpacing];
    [self layoutIfNeeded];

    
    self.contentLab.textColor = BSCOLOR_4B4B4B;
    if (indexPath.section) {
        self.contentLab.isCopyable = NO;
    }else {
       
        self.contentLab.isCopyable = YES;
    }
    
}

+ (CGFloat)heightForCellWithModel:(BSTradeModel *)model indexPath:(NSIndexPath *)indexPath{
    
    NSString * str;
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                str = model.myaddresses;
            }
            
            if (indexPath.row == 1) {
                str = model.addresses;
            }
        }
            break;
            
            
        case 1:
        {
            if (indexPath.row == 0) {
                str = model.txid;
            }
            
            
            if (indexPath.row == 1) {
                str = model.time;
            }
        }
            break;
        default:
            break;
    }
    
    
    
    

    
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];
    
    CGSize size = [str BS_boundingRectWithSize:CGSizeMake(BSScreen_Width - 45, 9999) attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:titleFont}];
    
    CGFloat height = 45 + size.height + 40;
    
    return height;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:14.0f];
        _titleLab.textColor = BSCOLOR_CCC;
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:14.0f];
        _contentLab.textColor = BSCOLOR_A7A7A7;
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

@end
