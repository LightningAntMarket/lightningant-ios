//
//  BSTaskListViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskListViewController.h"
#import "BSTaskTableViewCell.h"
#import "BSTaskDetailViewController.h"
#import "BSTaskModel.h"


@interface BSTaskListViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray     *_indexPaths;
}
@property (nonatomic) UITableView * tableView;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSMutableArray<BSTaskModel *>* dataArray;
@end

@implementation BSTaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reLoadData)
                                                 name:BSTaskListNeedReloadNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.tableView.noteView.frame = self.view.bounds;
    
}


#pragma mark - Delegate
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSTaskTableViewCell *cell = [BSTaskTableViewCell cellForTableView:tableView];
    [cell configCellWithModel:self.dataArray[indexPath.row] indexPath:indexPath];
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BSTaskDetailViewController * vc = [[BSTaskDetailViewController alloc]initWithTaskModel:self.dataArray[indexPath.row]];
    [self.nav pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *array = [tableView indexPathsForVisibleRows];
    
    for (NSIndexPath *index in _indexPaths) {
        if (index.row == indexPath.row) {
            return;
        }
    }
    NSIndexPath *lastCellIndexPath = _indexPaths.lastObject;
    
    if (indexPath.row < lastCellIndexPath.row) {
        cell.transform = CGAffineTransformTranslate(cell.transform, 0, -150);
    }else {
        cell.transform = CGAffineTransformTranslate(cell.transform, 0, 150);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        cell.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
    
    _indexPaths = [array copy];
}

- (void)loadData {
    NSString * url = [NSString stringWithFormat:GETHotTask,self.page];
    
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        
        if (self.page == 1){
            [self.dataArray removeAllObjects];
        }
        
        if ([[json valueForKey:@"status"] intValue] == 1) {
            NSArray *dataArr = [json valueForKey:@"data"];
            
            for (NSDictionary *dic in dataArr) {
                BSTaskModel *model = [[BSTaskModel alloc] initContentWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self checkData];
        }else {
            //没有数据
            [self checkData];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failure:^(NSError *error) {
        [self checkData];
    }];
}


- (void)checkData {
    [self hideHUD];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}



- (void)reLoadData {
    self.page = 1;
    [self loadData];
   
}

- (void)next {
    self.page++;
    [self loadData];
}

#pragma mark - private method
- (void)commonInit {
    [self.view addSubview:self.tableView];
    self.page = 1;
    [self showHUDInView:self.view];
    [self loadData];
}

#pragma mark - setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;;
        _tableView.backgroundColor                = [UIColor clearColor];
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.mj_header = [BSRefresh headerAnimationWithRefreshingTarget:self refreshingAction:@selector(reLoadData)];
        _tableView.mj_footer = [BSRefresh footerWithRefreshingTarget:self refreshingAction:@selector(next)];
        [_tableView addNoteViewWithpicName:@"app_nodata.png" noteText:BSLocalizedString(@"no.relevant.data") refreshBtnImg:nil];

    }
    return _tableView;
}

- (NSMutableArray<BSTaskModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
