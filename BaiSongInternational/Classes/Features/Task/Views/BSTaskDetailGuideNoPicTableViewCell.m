//
//  BSTaskDetailGuideNoPicTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailGuideNoPicTableViewCell.h"


@implementation BSTaskDetailGuideNoPicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskDetailGuideNoPicTableViewCellID";
    BSTaskDetailGuideNoPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskDetailGuideNoPicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    
    [self.contentView addSubview:self.rowImgView];
    [self.contentView addSubview:self.rowNumLab];
    [self.contentView addSubview:self.descLab];
  
    
    
    [self layoutCustomViews];
}



- (void)layoutCustomViews {
    
    [self.rowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.rowNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rowImgView);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rowNumLab);
        make.left.mas_equalTo(self.rowImgView.mas_right).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];

}

- (void)configCellWithModel:(BSTsakExeStepModel *)model indexPath:(NSIndexPath *)indexPath {
    self.rowNumLab.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
    self.descLab.text = model.text;
    [self.descLab BS_setLineSpacingIfMoreThanOneLine:17];
}




@end
