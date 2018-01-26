//
//  BSOrderListSuperViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderListSuperViewController.h"

#import "BSOrderDetailViewController.h"

@interface BSOrderListSuperViewController ()

@end

@implementation BSOrderListSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    
    if (@available(iOS 11, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    [self.tableView layoutNoteFrame];

}

#pragma mark - network

- (void)loadData {
    
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
    self.page ++ ;
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
        [_tableView addNoteViewWithpicName:@"app_nodata.png" noteText:BSLocalizedString(@"no.relevant.data") refreshBtnImg:nil];
        
    }
    return _tableView;
    
}

- (NSMutableArray <BSOrderModel *>*)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
