//
//  BSTaskDetailDoneUserCollectionViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailDoneUserCollectionViewCell.h"

@interface BSTaskDetailDoneUserCollectionViewCell ()

@end

@implementation BSTaskDetailDoneUserCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imgView];
        
        [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
    }
    return self;
}


- (UIImageView *)imgView
{
    if (!_userImg) {
        _userImg = [[UIImageView alloc] init];
        _userImg.layer.cornerRadius = 22;
        _userImg.layer.masksToBounds = YES;
        _userImg.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _userImg.layer.borderWidth = 0.5;
        _userImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _userImg;
}
@end
