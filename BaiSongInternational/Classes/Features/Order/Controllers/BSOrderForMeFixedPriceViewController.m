//
//  BSOrderForMeFixedPriceViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderForMeFixedPriceViewController.h"

#import "BSOrderDetailViewController.h"

static NSString * OrderSendList;

@interface BSOrderForMeFixedPriceViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BSOrderForMeFixedPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - delegate
#pragma mark  UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.dataArray[section].ostate integerValue] >= 7) {
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
            cell.type = BSOrderViewType_OrderIssued;
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
    
    BSOrderDetailViewController * vc = [[BSOrderDetailViewController alloc]initWithModel:self.dataArray[indexPath.section] type:BSOrderViewType_OrderIssued];
    [self.nav pushViewController:vc animated:YES];
}



#pragma mark - network
- (void)loadData {
    
    NSString * url = [NSString stringWithFormat:OrderSendList,self.page];
    
    [[BSNetWorking shareInstance]GET:url refresh:NO success:^(id json) {
        
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        
        if ([[json valueForKey:@"status"] intValue] == 1) {
            
            
            
            
            for (NSDictionary * dic in [json valueForKey:@"data"]) {
                BSOrderModel * model = [[BSOrderModel alloc]initContentWithDic:dic];
                model.time = @"";
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
    } failure:^(NSError *error) {
        [self checkData];
    }];
}


- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];
    //tag = 10000隐藏BSOrderTableViewContentCell的横线
    self.tableView.tag = 10000;
    [self showHUDInView:self.view];
    [self loadData];
    
}


@end
