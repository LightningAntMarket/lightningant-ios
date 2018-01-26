//
//  BSOrderDetailDataTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/19.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderDetailDataTableViewCell.h"



#define topOffSet 27.0f

@interface BSOrderDetailDataTableViewCell ()


@property (nonatomic) NSArray * labTitleArr;
@property (nonatomic) NSMutableArray<UILabel *> * labArr;
@property (nonatomic) UIView * line;
@end

@implementation BSOrderDetailDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSOrderDetailDataTableViewCellID";
    BSOrderDetailDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSOrderDetailDataTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    self.labTitleArr = @[BSLocalizedString(@"logistics.company"),BSLocalizedString(@"tracking.number"),BSLocalizedString(@"order.number"),BSLocalizedString(@"time.of.order"),BSLocalizedString(@"receiving.time")];
    
    [self.labArr removeAllObjects];
    
    for (int i = 0; i < self.labTitleArr.count; i ++) {
        UILabel * lab = [UILabel new];
        lab.font = [UIFont systemFontOfSize:16.0f];
        lab.textColor = BSCOLOR_4B4B4B;
        [self.contentView addSubview:lab];
        [self.labArr addObject:lab];
    }
    
    [self.contentView addSubview:self.line];
    
    
    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    
    for (int i = 0; i < self.labArr.count; i ++) {
        if (!i) {
            [self.labArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20.0f);
                make.top.equalTo(self.contentView).offset(10+topOffSet);
                make.right.equalTo(self.contentView).offset(-20.0f);
            }];
        } else {
            [self.labArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20.0f);
                make.top.mas_equalTo(self.labArr[i - 1].mas_bottom).offset(topOffSet);
                make.right.equalTo(self.contentView).offset(-20.0f);
            }];
        }
    }
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
}

- (void)configureCellForRowAtIndexPath:(NSIndexPath *)indexPath model:(BSOrderModel *)model tableView:(UITableView *)tableView {

    for (int i = 0; i < self.labArr.count; i ++) {
        NSString * str;
        switch (i) {
            case 0:
            {
                str = model.express_company.length?model.express_company:BSLocalizedString(@"no.data.for.now");
            }
                break;
            case 1:
            {
                str = model.express_number.length?model.express_number:BSLocalizedString(@"no.data.for.now");
            }
                break;
            case 2:
            {
                str = model.oid;
            }
                break;
            case 3:
            {
                str  = [model.time timeYMDFromTimestamp];
            }
                break;
            case 4:
            {
                if ([model.ostate intValue] == 8) {
                    //关闭时间
                    //                str = [model.time timeYMDFromTimestamp];
                }else {
                    
                    //                str = [model.time timeYMDFromTimestamp];
                }
            }
                break;
                
            default:
                break;
        }
        
        self.labArr[i].text = [NSString stringWithFormat:@"%@: %@",self.labTitleArr[i],str];
        
        
        
    }
    
    if ([model.ostate intValue] == 8) {
        //关闭时间
        self.labArr[4].text = [NSString stringWithFormat:@"%@: %@",BSLocalizedString(@"closing.time"),[model.returntime timeYMDFromTimestamp]];
    }else {
        //完成时间
        NSString * str = @"暂无";
        if (model.confirmtime.length) {
            str = [model.confirmtime timeYMDFromTimestamp];
        }
        self.labArr[4].text = [NSString stringWithFormat:@"%@: %@",BSLocalizedString(@"finishing.time"),str];
    }
    
    
}


- (NSMutableArray<UILabel *> *)labArr {
    if (!_labArr) {
        _labArr = [NSMutableArray new];
    }
    return _labArr;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

@end
