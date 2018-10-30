//
//  BSTaskDetailDoneUserCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailDoneUserCell.h"
#import "BSTaskDetailDoneUserCollectionViewCell.h"
#import "BSLoginManager.h"

@interface BSTaskDetailDoneUserCell()<UICollectionViewDelegate , UICollectionViewDataSource>

@property (strong , nonatomic) UICollectionView *collectionView;
@property (strong , nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) BSTaskModel * model;
@end

@implementation BSTaskDetailDoneUserCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSTaskDetailDoneUserCellID";
    BSTaskDetailDoneUserCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[BSTaskDetailDoneUserCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
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
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(44);
        }];
        
        [self.collectionView registerClass:[BSTaskDetailDoneUserCollectionViewCell class] forCellWithReuseIdentifier:@"BSTaskDetailDoneUserCollectionViewCellID"];
    }
    return self;
}


- (void)configCellWithModel:(BSTaskModel *)model indexPath:(NSIndexPath *)indexPath {
    self.model = model;
}

#pragma mark - collection view delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.complete_user.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSTaskDetailDoneUserCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"BSTaskDetailDoneUserCollectionViewCellID" forIndexPath:indexPath];
    [cell.userImg bs_setImageWithURL:[NSURL URLWithString:self.model.complete_user[indexPath.row].face] placeholderImage:nil];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(44,44);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *currentVC = [self getCurrentViewController];
    
    if (![[BSLoginManager shareInstance] isLogin]) {
        [[BSLoginManager shareInstance] showLoginWithViewController:currentVC];
        return;
    }
    [[BSConvenientOperationManager shareInstance] pushOthersController:currentVC userID:self.model.complete_user[indexPath.row].uid];
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
        _flowLayout.minimumLineSpacing      = 15;
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
