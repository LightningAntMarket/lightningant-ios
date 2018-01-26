//
//  BSDetailOfBlockchainViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSDetailOfBlockchainViewController.h"

#import "BSDetailOfBlockchainTableViewCell.h"
#import "BSDetailOfBlockchainTableHeaderView.h"



@interface BSDetailOfBlockchainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView     *tableView;
@property (nonatomic) NSMutableArray <UIView *> *headerViews;
@property (nonatomic) BSDetailOfBlockchainTableHeaderView * tableHeaderView;

@property (nonatomic) BSTradeModel  * model;
@end

@implementation BSDetailOfBlockchainViewController

- (instancetype)initWithModel:(BSTradeModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}



#pragma mark- delegate
#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRow = [BSDetailOfBlockchainTableViewCell heightForCellWithModel:self.model indexPath:indexPath];

    return heightForRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id cellX = [UITableViewCell new];
    
    BSDetailOfBlockchainTableViewCell * cell = [BSDetailOfBlockchainTableViewCell cellForTableView:tableView];
    [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
    
    cellX = cell;
    
    return cellX;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headerViews[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - private method

- (void)commonInit
{
    self.title = BSLocalizedString(@"details.of.the.trade");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
  
    
    [self.tableHeaderView configureHeaderViewWithModel:self.model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - setter && getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.backgroundColor                = [UIColor clearColor];
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}


- (NSMutableArray<UIView *> *)headerViews {
    if (!_headerViews) {
        _headerViews = [NSMutableArray new];
        for (int i = 0; i < 2; i ++) {
            UIView * view = [UIView new];
            UIView * line = [UIView new];
            line.backgroundColor = BSCOLOR_F3F3F3;
            [view addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).offset(20.0f);
                make.right.equalTo(view).offset(-20.0f);
                make.top.equalTo(view);
                make.height.mas_equalTo(0.5f);
            }];
            
            [_headerViews addObject:view];
        }
        
    }
    
    return _headerViews;
}

- (BSDetailOfBlockchainTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[BSDetailOfBlockchainTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, BSScreen_Width, BSDetailOfBlockchainTableHeaderViewHeight)];
    }
    return _tableHeaderView;
}

@end
