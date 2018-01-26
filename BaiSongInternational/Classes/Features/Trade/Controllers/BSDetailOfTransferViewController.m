//
//  BSDetailOfTransferViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/26.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSDetailOfTransferViewController.h"

#import "BSDetailOfTransferTableViewTitleCell.h"
#import "BSBusinessDetailTableViewNumCell.h"
#import "BSDetailOfTransferTableViewUserInfoCell.h"
#import "BSBusinessDetailTimeTableViewCell.h"

static NSString * getFaceByUid = @"Android/user/getFaceByUid/uid/%@";

@interface BSDetailOfTransferViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView     *tableView;

@property (nonatomic) BSTradeModel  * model;
@end

@implementation BSDetailOfTransferViewController

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
    
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRow = CGFLOAT_MIN;
    switch (indexPath.row) {
        case 0:
        {
            heightForRow = BSBusinessDetailTimeTableViewCellHeight;
            
        }
            break;
        case 1:
        {
            heightForRow = BSBusinessDetailTableViewNumCellHeight;
        }
            break;
        case 2:
        {
            heightForRow = [BSDetailOfTransferTableViewUserInfoCell heightForCellWithModel:self.model];
        }
            break;
        case 3:
        {
            heightForRow = BSBusinessDetailTimeTableViewCellHeight;
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
    switch (indexPath.row) {
        case 0:
        {
            BSDetailOfTransferTableViewTitleCell * cell = [BSDetailOfTransferTableViewTitleCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:nil tableView:tableView];
            cellX = cell;
        }
            break;
        case 1:
        {
            BSBusinessDetailTableViewNumCell * cell = [BSBusinessDetailTableViewNumCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
            cellX = cell;
        }
            break;
        case 2:
        {
            BSDetailOfTransferTableViewUserInfoCell * cell = [BSDetailOfTransferTableViewUserInfoCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
            cellX = cell;
        }
            break;
        case 3:
        {
            BSBusinessDetailTimeTableViewCell * cell = [BSBusinessDetailTimeTableViewCell cellForTableView:tableView];
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



- (void)loadData {
    
    NSString * url = [NSString stringWithFormat:getFaceByUid,self.model.uid];
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] integerValue] == 1) {
            self.model.nickname = json[@"data"][@"nickname"];
            self.model.face = json[@"data"][@"face"];
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
}



#pragma mark - private method

- (void)commonInit
{
    self.title = BSLocalizedString(@"details.of.the.trade");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
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
    }
    return _tableView;
}

@end
