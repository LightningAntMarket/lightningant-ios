//
//  BSTaskDetailGuideTableViewCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailGuideTableViewCell.h"
#import "BSPhotosPreviewViewController.h"

@interface BSTaskDetailGuideTableViewCell ()<BSPhotosPreviewViewControllerDelegate>
@property (nonatomic) BSTsakExeStepModel * model;

@end

@implementation BSTaskDetailGuideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskDetailGuideTableViewCellID";
    BSTaskDetailGuideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskDetailGuideTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    [self.contentView addSubview:self.picImgView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.picImgView addGestureRecognizer:tapGesture];
  
    [self layoutCustomViews];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap {
    BSPhotosPreviewViewController *previewVC = [[BSPhotosPreviewViewController alloc] init];
    previewVC.delegate = self;
    previewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[self getCurrentViewController] presentViewController:previewVC animated:YES completion:nil];
    [previewVC setCurrentPhotoIndex:0];
}

#pragma mark - BSPhotosPreviewViewController

- (NSInteger)numberOfPhotosInPhotoBrowser:(BSPhotosPreviewViewController *)photoBrowser
{
    return 1;
}

//需要反回 UIImage / NSURL 类型，其他类型报错
- (id)photoBrowser:(BSPhotosPreviewViewController *)photoBrowser photoAtIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.model.img];
}

- (NSString *)photoBrowser:(BSPhotosPreviewViewController *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index
{
    return @"";
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
    }];
    
    [self.picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLab);
        make.top.mas_equalTo(self.descLab.mas_bottom).offset(25);
        make.width.height.mas_equalTo(120);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
}


- (void)configCellWithModel:(BSTsakExeStepModel *)model indexPath:(NSIndexPath *)indexPath {
    self.model = model;
    self.rowNumLab.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
    self.descLab.text = model.text;
    [self.descLab BS_setLineSpacingIfMoreThanOneLine:17];
    [self.picImgView bs_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
}

- (UIImageView *)rowImgView {
    if (!_rowImgView) {
        _rowImgView = [UIImageView new];
        _rowImgView.image = [UIImage imageNamed:@"task_detail_rowBg.png"];
    }
    return _rowImgView;
}

- (UILabel *)rowNumLab {
    if (!_rowNumLab) {
        _rowNumLab = [UILabel new];
        _rowNumLab.font = [UIFont systemFontOfSize:12];
        _rowNumLab.textColor = [UIColor whiteColor];
    }
    return _rowNumLab;
}

- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [UILabel new];
        _descLab.font = [UIFont systemFontOfSize:14];
        _descLab.textColor = [UIColor colorWithHexString:@"63666d"];
        _descLab.numberOfLines = 0;
    }
    return _descLab;
}


- (UIImageView *)picImgView {
    if (!_picImgView) {
        _picImgView = [UIImageView new];
        _picImgView.contentMode = UIViewContentModeScaleAspectFit;
        _picImgView.layer.borderColor = BSCOLOR_F3F3F3.CGColor;
        _picImgView.layer.borderWidth = 0.5;
        _picImgView.userInteractionEnabled = YES;
    }
    return _picImgView;
}


@end
