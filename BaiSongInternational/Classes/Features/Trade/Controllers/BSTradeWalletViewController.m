//
//  BSTransactionWalletViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradeWalletViewController.h"
#import "BSTradeWalletTableViewFirstSecionCell.h"
#import "BSTradeWalletOptionView.h"
#import "BSTradeListTableCell.h"

#import "BSTradeModel.h"


#import "BSBusinessDetailViewController.h"
#import "BSDetailOfBlockchainViewController.h"
#import "BSDetailOfTransferViewController.h"

#import "BSTradeBlockKeyCrossingViewController.h"
#import "BSTradeListViewController.h"


#import "BSBaseNavigationController.h"
#import "BSTradeWalletTableHeaderView.h"
#import "BSTradeBlockKeyBackUpViewController.h"

static NSString * GetUserInfo;

#define tableViewFooterHeight 55.0f

@interface BSTradeWalletViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView     *tableView;

@property (nonatomic) BSTradeWalletTableHeaderView * tableHeaderView;

@property (nonatomic) BSTradeWalletOptionView * optionView;

@property (nonatomic) UIView * tableFooterView;

@property (nonatomic) BSTradeModel * model;

@end

@implementation BSTradeWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height- tableViewFooterHeight);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

#pragma mark- delegate
#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 2;
    
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
            heightForRow = BSTradeWalletTableViewFirstSecionCellHeight;
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
            BSTradeWalletTableViewFirstSecionCell * cell = [BSTradeWalletTableViewFirstSecionCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
            cellX = cell;
        }
            break;            
        default:{
            cellX = [UITableViewCell new];
        }
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
    if (!section) {
        return self.optionView;
    }
    return [UIView new];
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (!section) {
        return BSTradeWalletOptionViewHeight;
    }
    return CGFLOAT_MIN;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
  
}




#pragma mark - private method

- (void)commonInit
{
    self.title = BSLocalizedString(@"LAP.wallet");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.tableFooterView];
    
    [self.tableFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(tableViewFooterHeight);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - network
- (void)loadData {
    NSString * url = GetUserInfo;
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] intValue] == 1) {
            
            self.model = [[BSTradeModel alloc]initContentWithDic:json[@"data"]];
            self.optionView.model = self.model;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
}

- (void)leftBtnClick {
    //查看私钥

    
    [self.navigationController pushViewController:[BSTradeBlockKeyBackUpViewController new] animated:YES];
}

- (void)rightbtnClick {
    //交易记录
    [self.navigationController pushViewController:[BSTradeListViewController new] animated:YES];
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

- (BSTradeWalletTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[BSTradeWalletTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, BSScreen_Width, BSTradeWalletTableHeaderViewHeight)];
    }
    return _tableHeaderView;
}

- (BSTradeWalletOptionView *)optionView {
    if (!_optionView) {
        _optionView =[[BSTradeWalletOptionView alloc]initWithFrame:CGRectMake(0, 0, BSScreen_Width, BSTradeWalletOptionViewHeight)];
    }
    return _optionView;
}

- (UIView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [UIView new];
        _tableFooterView.backgroundColor = [UIColor whiteColor];
        UIButton * left = [UIButton new];
        [left setTitle:BSLocalizedString(@"check.the.private.key") forState:UIControlStateNormal];
        [left setTitleColor:BSCOLOR_337FDD forState:UIControlStateNormal];
        left.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [left addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * line = [UIView new];
        line.backgroundColor = BSCOLOR_337FDD;
        
        UIButton * right = [UIButton new];
        [right setTitle:BSLocalizedString(@"transaction.record") forState:UIControlStateNormal];
        [right setTitleColor:BSCOLOR_337FDD forState:UIControlStateNormal];
        right.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [right addTarget:self action:@selector(rightbtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_tableFooterView addSubview:left];
        [_tableFooterView addSubview:line];
        [_tableFooterView addSubview:right];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_tableFooterView);
            make.height.mas_equalTo(15.0f);
            make.centerY.equalTo(_tableFooterView);
            make.width.mas_equalTo(0.5f);
        }];
        
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(line.mas_centerX).offset(-14.0f);
            make.centerY.equalTo(line);
        }];
        
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_centerX).offset(14.0f);
            make.centerY.equalTo(line);
        }];


    }
    
    return _tableFooterView;
}

@end
