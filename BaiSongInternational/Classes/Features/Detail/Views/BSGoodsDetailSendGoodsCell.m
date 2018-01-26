//
//  BSGoodsDetailSendGoodsCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailSendGoodsCell.h"
#import "BSGoodsDetailSendGoodsCollectionViewCell.h"
#import "BSGoodsDetailViewController.h"

@interface BSGoodsDetailSendGoodsCell()<UICollectionViewDelegate , UICollectionViewDataSource>

@property (strong , nonatomic) UICollectionView *collectionView;
@property (strong , nonatomic) UILabel          *sendTitle;

@end

@implementation BSGoodsDetailSendGoodsCell

static NSString * const reuseIdentifier = @"BSGoodsDetailSendGoodsCollectionViewCellID";

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailSendGoodsCellID";
    BSGoodsDetailSendGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[BSGoodsDetailSendGoodsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
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
        [self.contentView addSubview:self.sendTitle];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(73);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [self.sendTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(28);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
        
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    if (!dataArr.count) {
        self.sendTitle.hidden = YES;
        self.collectionView.hidden = YES;
    }else{
        self.sendTitle.hidden = NO;
        self.collectionView.hidden = NO;
    }
    [self.collectionView reloadData];
}


#pragma mark - collection view delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSGoodsDetailSendGoodsCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.goods = self.dataArr[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(157, 289);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSGoodsDetailViewController * vc = [[BSGoodsDetailViewController alloc]initWithGid:self.dataArr[indexPath.row].gid];
    [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView == self.collectionView){
        
        //检测左测滑动,开始加载更多
        if(scrollView.contentOffset.x +scrollView.width - scrollView.contentSize.width >30){
            
            if ([self.delegate respondsToSelector:@selector(needLoadMoreData)]) {
                [self.delegate needLoadMoreData];
            }
            
        }
    }
}

#pragma mark - getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor=[UIColor whiteColor];
        [_collectionView registerClass:[BSGoodsDetailSendGoodsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

- (UILabel *)sendTitle
{
    if (!_sendTitle) {
        _sendTitle             = [[UILabel alloc] init];
        _sendTitle.font        = [UIFont boldSystemFontOfSize:16];
        _sendTitle.textColor   = BSCOLOR_4B4B4B;
        _sendTitle.text        = BSLocalizedString(@"other.list");
    }
    return _sendTitle;
}


@end
