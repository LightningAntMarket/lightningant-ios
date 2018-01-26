//
//  BSGoodsDetailJoinCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailJoinCell.h"
#import "BSGoodsDetailJoinInfoCell.h"
#import "BSGoodsDetailModel.h"
#import "BSGoodsDetailRecordViewController.h"

@interface BSGoodsDetailJoinCell()<UITableViewDelegate , UITableViewDataSource>

@property (strong , nonatomic) UITableView *tableView;
@property (strong , nonatomic) UIView      *line;

@end

@implementation BSGoodsDetailJoinCell

static NSString * const headerReuseIdentifier = @"DetailParticipatorHeaderReuseIdentifier";
static NSString * const footerReuseIdentifier = @"DetailParticipatorFooterReuseIdentifier";

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailJoinCellID";
    BSGoodsDetailJoinCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailJoinCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        [self.contentView addSubview:self.tableView];
        [self.contentView addSubview:self.line];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
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

+ (CGFloat)heightForCellWithModel:(BSGoodsDetailModel *)detailModel
{
    if (detailModel.joinUsers.count > 3) {
        return 60 + 15 + 3*70;
        
    }else if(detailModel.joinUsers.count == 0){
        return 0;
    }else{
        return 60 + 15 + detailModel.joinUsers.count*70;
    }
}

- (void)setDetailModel:(BSGoodsDetailModel *)detailModel
{
    _detailModel = detailModel;
    [self.tableView reloadData];
}

#pragma mark - action

- (void)moreButtonAction
{
    UIViewController *currentVC = [self getCurrentViewController];
    NSString *gid  = self.detailModel.goods.gid;
    NSInteger type = [self.detailModel.goods.modetype integerValue];
    BSGoodsDetailRecordViewController *recordList = [[BSGoodsDetailRecordViewController alloc] initWithGid:gid publishType:type];
    [currentVC.navigationController pushViewController:recordList animated:YES];
}

#pragma mark - table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.detailModel.joinUsers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSGoodsDetailJoinInfoCell *cell = [BSGoodsDetailJoinInfoCell cellForTableView:tableView];
    cell.joinUser = self.detailModel.joinUsers[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    
    if (!header) {
        header = (UITableViewHeaderFooterView *)[self viewForHeaderInSection];
    }
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerReuseIdentifier];
    
    if (!footer) {
        footer = (UITableViewHeaderFooterView *)[self viewForFooterInSection];
    }
    return footer;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UITableViewHeaderFooterView *)viewForFooterInSection
{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerReuseIdentifier];
    header.contentView.backgroundColor = [UIColor whiteColor];
    return header;
}

- (UITableViewHeaderFooterView *)viewForHeaderInSection
{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerReuseIdentifier];
    header.contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] init];
    title.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    title.font = [UIFont boldSystemFontOfSize:16];
    title.text = BSLocalizedString(@"record.of.participation");
    [header addSubview:title];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:BSLocalizedString(@"goodsdetail.more") forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor colorWithHexString:@"4b4b4b"] forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:moreButton];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_top).offset(28);
        make.left.equalTo(header.mas_left).offset(17);
    }];
    
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.width.equalTo(@50);
        make.right.equalTo(header.mas_right).offset(-20);
        make.top.equalTo(header.mas_top).offset(25);
    }];
    
    return header;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}
@end
