//
//  BSWalletListViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletListViewController.h"
#import "BSWalletListTableFooterView.h"
#import "BSWalletListCell.h"
#import "BSWalletCache.h"
#import "BSTradeBlockKeyImportViewController.h"
#import "BSWalletCheckUserViewController.h"
#import "BSBaseNavigationController.h"

@interface BSWalletListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView     *tableView;
@property (nonatomic) BSWalletDataSource * dataSource;
@property (nonatomic) BSWalletListTableFooterView * footerView;
@end

@implementation BSWalletListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.dataSource.dirty) {
        //更新数据
        self.dataSource = [BSWalletCache shareInstance].walletDataSrource;
        [self.tableView reloadData];
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- delegate
#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataSource.walletDatas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return BSWalletListCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id cellX;
    BSWalletListCell * cell = [BSWalletListCell cellForTableView:tableView];
//    [cell configureCellForRowAtIndexPath:indexPath model:self.dataArray[indexPath.row] tableView:tableView];
    [cell configureCellForRowAtIndexPath:indexPath model:self.dataSource.walletDatas[indexPath.row] tableView:tableView];
    cellX = cell;
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


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (!indexPath.row) {
        
        //默认钱包不允许删除
        return NO;
        
    }
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return BSLocalizedString(@"delete");//默认文字为 Delete
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:BSLocalizedString(@"warning") message:BSLocalizedString(@"wallet.del.tip.1") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:BSLocalizedString(@"wallet.back.up") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            BSWalletCheckUserViewController * vc = [[BSWalletCheckUserViewController alloc]initWithWalletData:self.dataSource.walletDatas[indexPath.row]];
            BSBaseNavigationController * nav = [[BSBaseNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            
        }];
        
        [alert addAction:action1];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:BSLocalizedString(@"delete") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showHUDInView:self.view];
            __weak typeof(self) weakSelf = self;
            [[BSWalletCache shareInstance] delWalletDataWithPrivateKey:self.dataSource.walletDatas[indexPath.row].privateKey callback:^(NSError *err) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if (err) {
                    if (err.userInfo) {
                        [strongSelf showHint:err.userInfo[@"msg"]];
                    }else {
                        [strongSelf showHint:[NSString stringWithFormat:@"%@-%zd",BSLocalizedString(@"data.error"),err.code]];
                    }
                }else {
                    
                    if (strongSelf.dataSource.dirty) {
                        //更新数据
                        strongSelf.dataSource = [BSWalletCache shareInstance].walletDataSrource;
                        [strongSelf.tableView reloadData];
                    }
                    
                }
                [self hideHUD];
            }];
            
        }];
        [alert addAction:action2];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showHUDInView:self.view];
    __weak typeof(self) weakSelf = self;
    [[BSWalletCache shareInstance] setDefaultWalletData:self.dataSource.walletDatas[indexPath.row] callback:^(NSError *err) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf hideHUD];
        if (!err) {
            //更改成功
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }else {
            if (err.userInfo) {
                [strongSelf showHint:err.userInfo[@"msg"]];
            }else {
                [strongSelf showHint:[NSString stringWithFormat:@"%@-%zd",BSLocalizedString(@"data.error"),err.code]];
            }
            
        }
    }];
}


- (void)commonInit
{
    self.title = BSLocalizedString(@"wallet.wallet.list");
    

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

  
    
}



#pragma mark - setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;;
        _tableView.backgroundColor                = [UIColor clearColor];
        _tableView.tableFooterView = self.footerView;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}


- (BSWalletDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [BSWalletCache shareInstance].walletDataSrource;
    }
    return _dataSource;
}


- (BSWalletListTableFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[BSWalletListTableFooterView alloc]initWithFrame:CGRectMake(0, 0, BSScreen_Width, BSWalletListTableFooterViewHeight)];
    }
    return _footerView;
}
@end
