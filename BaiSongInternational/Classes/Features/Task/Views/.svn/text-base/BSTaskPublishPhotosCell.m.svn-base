//
//  BSTaskPublishPhotosCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/8.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishPhotosCell.h"

#import "BSPhotosPreviewSelectViewController.h"

#import "BSPublishUploadCollectionViewCell.h"

#import "BSPhotoAlbumsViewController.h"
#import "BSPhotosController.h"

#import "BSUploadModel.h"
#import "BSPhotosModel.h"

#import "UIImage+Extend.h"

#import "BSPhotosManager.h"
#import "BSAliyunOSSManager.h"


@interface BSTaskPublishPhotosCell()<UICollectionViewDelegate , UICollectionViewDataSource  , BSPhotosControllerDelegate , UINavigationControllerDelegate, UIImagePickerControllerDelegate,BSPhotosPreviewViewControllerDelegate>

@property (strong , nonatomic) UILabel *cellTitleLabel;

@property (strong , nonatomic) UICollectionView *collectionView;
@property (strong , nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong , nonatomic) NSMutableArray *imageModels;
@property (strong , nonatomic) NSMutableArray *assets;
@property (strong , nonatomic) NSMutableArray *imageURLs;//存储上传过的图片链接


@property (nonatomic) BSTaskPublishHelper * publishHelper;
@end

@implementation BSTaskPublishPhotosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskPublishPhotosCellID";
    BSTaskPublishPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskPublishPhotosCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
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
    
    
    
  
    [self.contentView addSubview:self.cellTitleLabel];
    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[BSPublishUploadCollectionViewCell class] forCellWithReuseIdentifier:@"BSPublishUploadCollectionViewCellID"];
    
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(18);
        make.top.equalTo(self.contentView.mas_top).offset(25);
    }];
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@120);
        make.top.equalTo(self.cellTitleLabel.mas_bottom).offset(25);
        make.right.equalTo(self.contentView.mas_right).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-40);
    }];
    
    [self.cellTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

    
}


#pragma mark - collection view delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageModels.count == 6?6:self.imageModels.count + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    self.cellTitleLabel.text = [NSString stringWithFormat:@"%@ (%zd/6)",BSLocalizedString(@"LN_localizable_2.0_45"),self.imageModels.count];
    
    BSPublishUploadCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"BSPublishUploadCollectionViewCellID" forIndexPath:indexPath];
    
    [cell setupCellWithIndexPath:indexPath images:self.imageModels];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 120);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.imageModels.count == 6) {
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:10];
        for (BSUploadModel *model in self.imageModels) {
            [images addObject:model.image];
        }
        
        BSPhotosPreviewSelectViewController *previewVC = [[BSPhotosPreviewSelectViewController alloc] initWithImages:images currentIndex:indexPath.item];
        previewVC.delegate = self;
        [[self currentViewController].navigationController pushViewController:previewVC animated:YES];
        
        return;
    }
    
    if (indexPath.item == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:BSLocalizedString(@"select.from.photo.album") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            BSPhotosController *photosVC = [[BSPhotosController alloc] initWithMaxCount:6 selectedCount:self.assets.count];
            photosVC.bs_delegate = self;
            [[self currentViewController] presentViewController:photosVC animated:YES completion:nil];
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:BSLocalizedString(@"take.a.picture") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [[BSPhotosManager shareInstance] requestAuthorizationCamera:^(BOOL status) {
                if (status) {
                    
                    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                        imagePickerController.delegate = self;
                        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [[self currentViewController] presentViewController:imagePickerController animated:YES completion:nil];
                    }
                }else{
                    //没有权限
                    
                }
            }];
            
        }];
        
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:BSLocalizedString(@"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action2];
        [alert addAction:action1];
        [alert addAction:action3];
        [[self currentViewController] presentViewController:alert animated:YES completion:nil];
    }else{
        
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:10];
        for (BSUploadModel *model in self.imageModels) {
            [images addObject:model.image];
        }
        
        BSPhotosPreviewSelectViewController *previewVC = [[BSPhotosPreviewSelectViewController alloc] initWithImages:images currentIndex:indexPath.item - 1];
        previewVC.delegate = self;
        [[self currentViewController].navigationController pushViewController:previewVC animated:YES];
        
    }
}

#pragma mark - delegate
- (void)didDeleteIndex:(NSInteger)index remainingPhotos:(NSArray <UIImage *>*)images
{
    [self.assets      removeObjectAtIndex:index];
    [self.imageURLs   removeObjectAtIndex:index];
    [self.imageModels removeObjectAtIndex:index];
    
    [self.collectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(didFinishUploadWithImages:)]) {
        [self.delegate didFinishUploadWithImages:self.imageURLs];
    }
}

//相册选择后的代理
- (void)didFinishSelectedPhotos:(NSArray <UIImage *>*)images assets:(NSArray *)assets
{
    if (self.imageModels.count >= 6) {
        //弹出警告
        
        return;
    }
    //包装image
    for (UIImage *image in images) {
        BSUploadModel *model = [BSUploadModel modelWithImage:image];
        [self.imageModels addObject:model];
    }
    
    [self.assets addObjectsFromArray:assets];
    
    [self.collectionView reloadData];
    
    //上传图片
    [self uploadImages:images];
}

//照相机代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.assets.count < 6) {
        
        //原始图片 UIImagePickerControllerOriginalImage
        UIImage *image0 = [info objectForKey:UIImagePickerControllerOriginalImage];
        //需要对拍照后的照片处理 不然会出现方向颠倒
        UIImage *image = [image0 fixOrientation];
        //保存至相册
        [[BSPhotosManager shareInstance] savePhotoWithImage:image completion:^{
            [[BSPhotosManager shareInstance] fetchCameraRollAlbums:^(BSAlbumModel *model) {
                
                //获取图片资源
                [[BSPhotosManager shareInstance] fetchAssetsResult:model.result collections:^(NSArray<BSAssetModel *> *models) {
                    
                    BSAssetModel *assetModel = [models lastObject];
                    
                    //获取图片image
                    [[BSPhotosManager shareInstance] requestImageForAsset:assetModel.asset photoWidth:BSScreen_Width resultHandler:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        
                        //菊花隐藏
                        
                        if (isDegraded){
                            return ;
                        }
                        
                        if (photo) {
                            photo = [self scaleImage:photo toSize:CGSizeMake(BSScreen_Width, (int)(BSScreen_Width * photo.size.height / photo.size.width))];
                            
                            //添加入模型
                            [self.assets addObject:assetModel.asset];
   
                            BSUploadModel *model = [BSUploadModel modelWithImage:image];
                            [self.imageModels addObject:model];
                            [self.collectionView reloadData];
                            
                            //上传图片
                            [self uploadImages:@[image]];
                            
                        }
                        
                    }];
                    
                }];
            }];
        }];
        
        
    }else {
        //弹出警告
        NSString *maxString = BSLocalizedString(@"add.pictures.up.to.6");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:BSLocalizedString(@"warning") message:maxString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:BSLocalizedString(@"ok") style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:alertAction];
        [[self currentViewController] presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - private

- (void)uploadImages:(NSArray *)images
{
    __weak BSTaskPublishPhotosCell *weakself = self;
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showHUDInView:[self getCurrentViewController].view text:@"图片上传中..."];
    
    BSAliyunOSSManager *manager = [BSAliyunOSSManager sharedInstance];
    [manager uploadImages:images progress:^(CGFloat completed) {
        
    } resultHandler:^(NSArray *responseObject) {
        
        if (responseObject.count > 0) {
            [self hideHUD];
            
            [self.imageURLs addObjectsFromArray:responseObject];
            if ([weakself.delegate respondsToSelector:@selector(didFinishUploadWithImages:)]) {
                [weakself.delegate didFinishUploadWithImages:self.imageURLs];
            }
        }
    }];
}

// Scale image / 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - getter

- (NSMutableArray *)imageModels
{
    if (!_imageModels) {
        _imageModels = [NSMutableArray arrayWithCapacity:10];
    }
    return _imageModels;
}

- (NSMutableArray *)assets
{
    if (!_assets) {
        _assets = [NSMutableArray arrayWithCapacity:10];
    }
    return _assets;
}

- (UILabel *)cellTitleLabel
{
    if (!_cellTitleLabel) {
        _cellTitleLabel = [[UILabel alloc] init];
        _cellTitleLabel.font = [UIFont systemFontOfSize:14];
        _cellTitleLabel.textColor = BSCOLOR_000;
        _cellTitleLabel.text = [NSString stringWithFormat:@"%@ (%zd/6)",BSLocalizedString(@"LN_localizable_2.0_45"),self.imageModels.count];
    }
    return _cellTitleLabel;
}


- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing      = 10;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor=[UIColor clearColor];
    }
    return _collectionView;
}

- (NSMutableArray *)imageURLs
{
    if (!_imageURLs) {
        _imageURLs = [NSMutableArray arrayWithCapacity:10];
    }
    return _imageURLs;
}

@end
