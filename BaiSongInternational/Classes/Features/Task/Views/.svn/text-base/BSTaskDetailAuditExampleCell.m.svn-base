//
//  BSTaskDetailAuditExampleCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailAuditExampleCell.h"
#import "BSShowImgCollectionViewCell.h"
#import "BSPhotosPreviewViewController.h"

@interface BSTaskDetailAuditExampleCell()<UICollectionViewDelegate , UICollectionViewDataSource,BSPhotosPreviewViewControllerDelegate>

@property (strong , nonatomic) UICollectionView *collectionView;
@property (strong , nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) BSTaskModel * model;
@end

@implementation BSTaskDetailAuditExampleCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSTaskDetailAuditExampleCellID";
    BSTaskDetailAuditExampleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[BSTaskDetailAuditExampleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-32);
            make.height.mas_equalTo(120);
        }];
        
        [self.collectionView registerClass:[BSShowImgCollectionViewCell class] forCellWithReuseIdentifier:@"BSShowImgCollectionViewCellID"];
    }
    return self;
}

- (void)configCellWithModel:(BSTaskModel *)model indexPath:(NSIndexPath *)indexPath {
    self.model = model;
}

#pragma mark - collection view delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.check_img.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSShowImgCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"BSShowImgCollectionViewCellID" forIndexPath:indexPath];
    [cell.imgView bs_setImageWithURL:[NSURL URLWithString:self.model.check_img[indexPath.row]] placeholderImage:nil];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120,120);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSPhotosPreviewViewController *previewVC = [[BSPhotosPreviewViewController alloc] init];
    previewVC.delegate = self;
    previewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[self getCurrentViewController] presentViewController:previewVC animated:YES completion:nil];
    [previewVC setCurrentPhotoIndex:indexPath.row];
}

#pragma mark - BSPhotosPreviewViewController

- (NSInteger)numberOfPhotosInPhotoBrowser:(BSPhotosPreviewViewController *)photoBrowser
{
    return self.model.check_img.count;
}

//需要反回 UIImage / NSURL 类型，其他类型报错
- (id)photoBrowser:(BSPhotosPreviewViewController *)photoBrowser photoAtIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.model.check_img[index]];
}

- (NSString *)photoBrowser:(BSPhotosPreviewViewController *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index
{
    return [NSString stringWithFormat:@"%zd/%zd",index+1,self.model.check_img.count];
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.dataSource =self;
        _collectionView.delegate   =self;
        //        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0,20, 0, 20);
        
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing      = 20;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
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
