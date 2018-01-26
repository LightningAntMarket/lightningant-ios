//
//  BSOrderDetailViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/19.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderDetailViewController.h"

#import "BSOrderStatusTableViewCell.h"
#import "BSOrderDetailConsigneeInfoTableViewCell.h"
#import "BSOrderDetailTableContentCell.h"
#import "BSOrderDetailDataTableViewCell.h"
#import "BSOrderDetailTableViewFooterCell.h"

#import "BSGoodsDetailViewController.h"

//抢到的
static NSString * orderDetailByGet;
//发布的
static NSString * orderSendDetail ;

@interface BSOrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView * tableView;

@property (nonatomic) BSOrderModel * model;

@property (nonatomic) BSOrderViewType type;

@end

@implementation BSOrderDetailViewController


- (instancetype)initWithModel:(BSOrderModel *)model type:(BSOrderViewType)type
{
    self = [super init];
    if (self) {
        self.model = model;
        self.type = type;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.type == BSOrderViewType_OrderIssued) {
        if ([self.model.ostate integerValue] >= 7) {
            return 4;
        }
    }else if ([self.model.ostate integerValue] == 7) {
        return 4;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height ;
    height = 20.0f;
    
    switch (indexPath.section) {
        case 0:
        {
            height = BSOrderStatusTableViewCellHeight;
        }
            break;
        case 1:
        {
            height = [BSOrderDetailConsigneeInfoTableViewCell heightForCellWithModel:self.model];
        }
            break;
        case 2:
        {
            height = BSOrderDetailTableContentCellHeight;
        }
            break;
            
        case 3:
        {
            height = BSOrderDetailDataTableViewCellHeight;
        }
            break;
        case 4:
        {
            height = BSOrderDetailTableViewFooterCellHeight;
        }
            break;
        default:
            break;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id cellX;
    
    
    switch (indexPath.section) {
        case 0:
        {
            BSOrderStatusTableViewCell * cell = [BSOrderStatusTableViewCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
            cellX = cell;
        }
            break;
        case 1:
        {
            BSOrderDetailConsigneeInfoTableViewCell * cell = [BSOrderDetailConsigneeInfoTableViewCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
            cellX = cell;
        }
            break;
        case 2:
        {
            BSOrderDetailTableContentCell * cell = [BSOrderDetailTableContentCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
            cellX = cell;
        }
            break;
        case 3:
        {
            BSOrderDetailDataTableViewCell * cell = [BSOrderDetailDataTableViewCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
            cellX = cell;
        }
            break;
            
        case 4:
        {
            BSOrderDetailTableViewFooterCell * cell = [BSOrderDetailTableViewFooterCell cellForTableView:tableView];
            cell.type = self.type;
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 2) {
        BSGoodsDetailViewController * vc = [[BSGoodsDetailViewController alloc]initWithGid:self.model.gid];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}


#pragma mark - network 
- (void)loadData {
    
    
    
    
    NSString * url = [NSString stringWithFormat:((self.type == BSOrderViewType_OrderAuction)?orderDetailByGet:orderSendDetail),self.model.oid];
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance]GET:url refresh:NO success:^(id json) {
        
        if ([[json valueForKey:@"status"] intValue] == 1) {
            
            [self.model configSendDataWithDic:json[@"data"]];
            
           
            
        }else{
            //没有数据

        }
        
        [self checkData];
   
    } failure:^(NSError *error) {
        [self checkData];
    }];
}

- (void)checkData {
    [self hideHUD];
    [self.tableView reloadData];
}

#pragma mark - provate method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.title = BSLocalizedString(@"details.of.the.order");
    
    [self loadData];
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
    }
    return _tableView;
}


@end
