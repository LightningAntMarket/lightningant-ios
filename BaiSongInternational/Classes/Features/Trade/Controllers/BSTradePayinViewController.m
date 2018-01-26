//
//  BSTradePayinViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/22.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradePayinViewController.h"



#import "BSTradePayinTableViewCell.h"
#import "BSTradeListTableCell.h"
#import "BSMineAddressSetupFooterView.h"
#import "BSDetailOfBlockchainViewController.h"



#import "UIViewController+DismissKeyboard.h"

#define firstSectionFooterViewHeiht 60.0f
#define secondSectionHeaderViewHeight 55.0f

@interface BSTradePayinViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView     *tableView;

@property (nonatomic) BSMineAddressSetupFooterView * firstSectionFooterView;
@property (nonatomic) UIView * secondSectionHeaderView;
@end

@implementation BSTradePayinViewController

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
    NSInteger numberOfRows = 0;
    switch (section) {
        case 0:
        {
            numberOfRows = 1;
        }
            break;

            
        default:
            break;
    }
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

            heightForRow = [BSTradePayinTableViewCell heightForCellWithModel:nil];
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
            BSTradePayinTableViewCell * cell = [BSTradePayinTableViewCell cellForTableView:tableView];
            [cell configureCellForRowAtIndexPath:indexPath model:nil tableView:tableView];
            cellX = cell;
 
            
            
        }
            break;

            
            
        default:
            break;
    }
    return cellX;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (section) {
        return self.secondSectionHeaderView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section) {
        return secondSectionHeaderViewHeight;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (!section) {
        return self.firstSectionFooterView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (!section) {
        return firstSectionFooterViewHeiht;
    }
    return CGFLOAT_MIN;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - touch event
- (void)firstSectionFooterViewClick {
    //copy
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    BSUser * user = [[BSDataBaseManager shareInstance] getUserInfo];
    pBoard.string = user.blockaddress;
    [self showHint:BSLocalizedString(@"copy.is.successfully")];
}


#pragma mark - private method

- (void)commonInit
{
    self.title = BSLocalizedString(@"trade.receiving");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
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


 


- (BSMineAddressSetupFooterView *)firstSectionFooterView {
    if (!_firstSectionFooterView) {

        _firstSectionFooterView = [[BSMineAddressSetupFooterView alloc]initWithBtnTitle:BSLocalizedString(@"copy.the.address") size:CGSizeMake(240.0f, BSMineAddressSetupFooterViewHeight)];
        _firstSectionFooterView.canTouch = YES;
        _firstSectionFooterView.touchEvent = @selector(firstSectionFooterViewClick);
    }
    return _firstSectionFooterView;
}

- (UIView *)secondSectionHeaderView {
    if (!_secondSectionHeaderView) {
        _secondSectionHeaderView = [UIView new];
        UILabel * textLab = [UILabel new];
        textLab.textColor = BSCOLOR_4B4B4B;
        textLab.font = [UIFont boldSystemFontOfSize:16.0f];
        textLab.text = @"Coin raising record";
        [_secondSectionHeaderView addSubview:textLab];
        [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_secondSectionHeaderView);
            make.left.equalTo(_secondSectionHeaderView).offset(20.0f);
        }];
    }
    return _secondSectionHeaderView;
}


@end
