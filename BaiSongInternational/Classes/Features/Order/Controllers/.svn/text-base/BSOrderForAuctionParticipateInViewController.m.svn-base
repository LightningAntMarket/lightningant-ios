//
//  BSOrderForAuctionParticipateInViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/13.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderForAuctionParticipateInViewController.h"

#import "BSGoodsDetailViewController.h"

static NSString * orderListGetAuction = @"Android/Order/orderListGetAuction/is_sale/1/p/%zd";

@interface BSOrderForAuctionParticipateInViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BSOrderForAuctionParticipateInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - delegate
#pragma mark  UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
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
    BSGoodsDetailViewController * vc = [[BSGoodsDetailViewController alloc]initWithGid:self.dataArray[indexPath.section].gid];
    [self.nav pushViewController:vc animated:YES];
}



#pragma mark - network
- (void)loadData {
 
    NSString * url = [NSString stringWithFormat:orderListGetAuction,self.page];


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
            }        }
        
        self.page++;
    } failure:^(NSError *error) {
        [self checkData];
    }];
    
  
}


- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self showHUDInView:self.view];
    [self loadData];
    
}

@end
