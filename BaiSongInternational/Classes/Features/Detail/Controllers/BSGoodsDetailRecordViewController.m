//
//  BSGoodsDetailRecordViewController.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/10/27.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailRecordViewController.h"
#import "BSJoinUser.h"
#import "BSGoodsDetailRecordCell.h"

@interface BSGoodsDetailRecordViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    int _currentPage;
}
@property (strong , nonatomic) UITableView    *tableView;
@property (strong , nonatomic) NSMutableArray *dataArr;

@property (weak , nonatomic)   NSString *gid;
@property (assign , nonatomic) PublishType type;

@end

@implementation BSGoodsDetailRecordViewController

- (instancetype)initWithGid:(NSString *)gid publishType:(PublishType)type
{
    self = [super init];
    if (self) {
        self.gid  = gid;
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_footer = [BSRefresh footerWithRefreshingTarget:self refreshingAction:@selector(loadingMoreData)];
    
    [self loadData];
}

- (void)commonInit
{
    self.navigationItem.title = BSLocalizedString(@"record.of.participation");
    _currentPage = 1;
}

- (void)loadData
{
    NSString *URLString ;
    
    if (self.type == PublishType_Oneoff) {
        URLString =     [NSString stringWithFormat:@"Android/goods/getMoreOnePriceJoins/gid/%@/p/%zd",self.gid,_currentPage];
    }else{
        URLString =     [NSString stringWithFormat:@"Android/goods/getMoreAuctionJoins/gid/%@/p/%zd",self.gid,_currentPage];
    }
    
    [self showHUDInView:self.view];
    
    [[BSNetWorking shareInstance] GET:URLString refresh:YES success:^(id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self hideHUD];
        
        NSInteger status = [[responseObject objectForKey:@"status"] intValue];
        
        if (status == 1) {
            NSArray *data  = [responseObject objectForKey:@"data"];
            NSArray *joins = [BSJoinUser mj_objectArrayWithKeyValuesArray:data];
            [self.dataArr addObjectsFromArray:joins];
        }else{
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        
        //没有更多数据了
        if (self.dataArr.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }

    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self hideHUD];
    }];
}

- (void)loadingMoreData
{
    //加载更多最新宝贝
    _currentPage = _currentPage + 1;
    [self loadData];
}

#pragma mark - table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.type == PublishType_Oneoff) {
        return 50;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSGoodsDetailRecordCell *cell = [BSGoodsDetailRecordCell cellForTableView:tableView];
    cell.joinUser = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (self.type != PublishType_Oneoff) {
        return nil;
    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BSScreen_Width, 50)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BSScreen_Width/3, 50)];
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = BSLocalizedString(@"user");
    [header addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(BSScreen_Width/3, 0, BSScreen_Width/3, 50)];
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    label2.textAlignment = NSTextAlignmentCenter;
    if (self.type == PublishType_Oneoff) {
        label2.text = BSLocalizedString(@"purchase");

    }else{
        label2.text = BSLocalizedString(@"bid");
    }
    [header addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(2*BSScreen_Width/3, 0, BSScreen_Width/3, 50)];
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = BSLocalizedString(@"time");
    [header addSubview:label3];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(BSScreen_Width/3, 17, 0.5, 15)];
    line1.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    [header addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(2*BSScreen_Width/3, 17, 0.5, 15)];
    line2.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    [header addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(17, 49.5, BSScreen_Width-34, 0.5)];
    line3.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    [header addSubview:line3];
    return header;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
