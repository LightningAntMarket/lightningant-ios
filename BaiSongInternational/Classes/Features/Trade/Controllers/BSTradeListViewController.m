//
//  BSTradeListViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2017/10/27.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeListViewController.h"

#import "BSTradeModel.h"

#import "BSTradeListTableCell.h"

#import "BSBusinessDetailViewController.h"
#import "BSDetailOfBlockchainViewController.h"
#import "BSDetailOfTransferViewController.h"
#import "BSRedPacketRecordViewController.h"

static NSString * getLog = @"Android/Block/getLog/p/%zd";

@interface BSTradeListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView     *tableView;
@property (nonatomic) NSMutableArray<BSTradeModel *> * dataArray;
@property (nonatomic) NSInteger page;
@end

@implementation BSTradeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    [self.tableView layoutNoteFrame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- delegate
#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    switch (section) {
        case 0:
        {
            numberOfRows = self.dataArray.count;
        }
            break;
            
            
        default:
            break;
    }
    return numberOfRows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRow = 0;
    switch (indexPath.section) {
        case 0:
        {
            
            heightForRow = BSTradeListTableCellHeight;
        }
            break;
            
            
        default:
            break;
    }
    return heightForRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id cellX;
    switch (indexPath.section) {
        case 0:
        {
            BSTradeListTableCell * cell = [BSTradeListTableCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.dataArray[indexPath.row] tableView:tableView];
            cellX = cell;
            
            
            
        }
            break;
            
            
            
        default:
            break;
    }
    return cellX;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray[indexPath.row].uid) {
        BSDetailOfTransferViewController * vc = [[BSDetailOfTransferViewController alloc]initWithModel:self.dataArray[indexPath.row]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        BSDetailOfBlockchainViewController * vc = [[BSDetailOfBlockchainViewController alloc]initWithModel:self.dataArray[indexPath.row]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}



#pragma mark - network


- (void)loadData {

    NSString * url = [NSString stringWithFormat:getLog,self.page];
    
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        
        if (self.page == 0){
            [self.dataArray removeAllObjects];
        }
        
        if ([[json valueForKey:@"status"] intValue] == 1) {
            NSArray *dataArr = [json valueForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
                BSTradeModel *model = [[BSTradeModel alloc] initContentWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self checkData];
        }else {
            //没有数据
            [self checkData];
            if (self.page != 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        self.page ++;
        
        
    } failure:^(NSError *error) {
        [self checkData];
    }];
}

- (void)next {
    [self loadData];
}
- (void)reLoadData {
    self.page = 0;
    [self loadData];
}

- (void)checkData {
    self.page ++ ;
    [self hideHUD];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

#pragma mark - private method

- (void)commonInit
{
    self.title = BSLocalizedString(@"transaction.record");
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"redpacket_trade_righticon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.page = 0;
    [self showHUDInView:self.view];
    [self loadData];
    
}

- (void)rightItemClick {
    //红包记录
    BSRedPacketRecordViewController * vc = [BSRedPacketRecordViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;;
        _tableView.backgroundColor                = [UIColor clearColor];
        
        //        _tableView.mj_header = [BSRefresh headerAnimationWithRefreshingTarget:self refreshingAction:@selector(reLoadData)];
        _tableView.mj_header = [BSRefresh headerAnimationWithRefreshingTarget:self refreshingAction:@selector(reLoadData)];
        _tableView.mj_footer = [BSRefresh footerWithRefreshingTarget:self refreshingAction:@selector(next)];
        
        [_tableView addNoteViewWithpicName:@"app_nodata.png" noteText:BSLocalizedString(@"no.relevant.data") refreshBtnImg:nil];
    }
    return _tableView;
}


- (NSMutableArray<BSTradeModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end
