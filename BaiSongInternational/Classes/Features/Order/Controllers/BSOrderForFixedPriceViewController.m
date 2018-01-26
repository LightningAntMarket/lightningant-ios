//
//  BSOrderForFixedPriceViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderForFixedPriceViewController.h"
#import "BSOrderTableViewTopCell.h"
#import "BSOrderTableViewContentCell.h"
#import "BSOrderTableViewFooterCell.h"

#import "BSOrderDetailViewController.h"

static NSString * orderListByGet = @"Android/Order/orderListByGet/modetype/2/p/%zd";

@interface BSOrderForFixedPriceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView    * tableView;
@property (nonatomic) NSMutableArray<BSOrderModel *> * dataArray;
@property (nonatomic) NSInteger      page;
@end

@implementation BSOrderForFixedPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    [self.tableView layoutNoteFrame];
}



#pragma mark - delegate
#pragma mark  UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.dataArray[section].ostate integerValue] == 7) {
        return 2;
    }
    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell_x;
    
    
    switch (indexPath.row) {
        case 0 :
        {
            BSOrderTableViewTopCell * cell = [BSOrderTableViewTopCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.dataArray[indexPath.section] tableView:tableView];
            cell_x = cell;
        }
            break;
            
        case 1 :
        {
            BSOrderTableViewContentCell * cell = [BSOrderTableViewContentCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.dataArray[indexPath.section] tableView:tableView];
            cell_x = cell;
        }
            break;
        case 2 :
        {
            BSOrderTableViewFooterCell * cell = [BSOrderTableViewFooterCell cellForTableView:tableView];
            cell.type = BSOrderViewType_OrderAuction;
            [cell configureCellForRowAtIndexPath:indexPath model:self.dataArray[indexPath.section] tableView:tableView];
            cell_x = cell;
        }
            break;
            
            
        default:
            break;
    }
    return cell_x;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return BSOrderTableViewTopCellHeight;
        }
            break;
        case 1:
        {
            return BSOrderTableViewContentCellHeight;
        }
            break;
        case 2:
        {
            return BSOrderTableViewFooterCellHeight;
        }
            break;
            
        default:
        {
            return 20.0f;
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView * footer        = [UIView new];
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * header        = [UIView new];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    BSOrderDetailViewController * vc = [[BSOrderDetailViewController alloc]initWithModel:self.dataArray[indexPath.section] type:BSOrderViewType_OrderAuction];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - network
- (void)loadData {
    
    NSString * url = [NSString stringWithFormat:orderListByGet,self.page];
    
    [[BSNetWorking shareInstance]GET:url refresh:NO success:^(id json) {
        
        if ([[json valueForKey:@"status"] intValue] == 1) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            
            
            for (NSDictionary * dic in [json valueForKey:@"data"]) {
                BSOrderModel * model = [[BSOrderModel alloc]initContentWithDic:dic];
                model.isBuyer = YES;
                [self.dataArray addObject:model];
            }
            [self checkData];
            
        }else{
            //没有数据
            [self checkData];
            if (self.page != 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        self.page++;
    } failure:^(NSError *error) {
        [self checkData];
    }];
}


- (void)commonInit {
    if (@available(iOS 11, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    
    self.title = BSLocalizedString(@"fixed.price.order");
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self showHUDInView:self.view];
    [self loadData];
    
}



- (void)next {
    self.page ++;
    [self loadData];
}
- (void)reLoadData {
    self.page = 1;
    [self loadData];
}

- (void)checkData {
    
    [self hideHUD];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}



#pragma mark - getter && setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.mj_header = [BSRefresh headerAnimationWithRefreshingTarget:self refreshingAction:@selector(reLoadData)];
        _tableView.mj_footer = [BSRefresh footerWithRefreshingTarget:self refreshingAction:@selector(next)];
        //tag = 10000隐藏BSOrderTableViewContentCell的横线
        _tableView.tag = 10000;
        
        [_tableView addNoteViewWithpicName:@"app_nodata.png" noteText:BSLocalizedString(@"no.relevant.data") refreshBtnImg:nil];
        
    }
    return _tableView;
}

- (NSMutableArray<BSOrderModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
