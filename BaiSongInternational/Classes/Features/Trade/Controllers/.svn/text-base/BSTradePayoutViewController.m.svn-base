//
//  BSTradePayoutViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/22.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSTradePayoutViewController.h"

#import "BSTradeModel.h"
 
#import "BSTradePayoutFirstSectionCell.h"
#import "BSTradePayoutFirstSectionTipCell.h"
#import "BSTradeListTableCell.h"
#import "BSMineAddressSetupFooterView.h"
#import "BSDetailOfBlockchainViewController.h"
#import "BSLoginManager.h"

#import "UIViewController+KeyboardCorver.h"
#import "UIViewController+DismissKeyboard.h"


#define firstSectionFooterViewHeiht 60.0f
#define secondSectionHeaderViewHeight 55.0f

@interface BSTradePayoutViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView     *tableView;
@property (nonatomic) BSMineAddressSetupFooterView * firstSectionFooterView;
@property (nonatomic) UIView * secondSectionHeaderView;
@end

@implementation BSTradePayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
    [self addNotification];
    [self setupForDismissKeyboard];
}


- (void)dealloc {
    [self clearKeyboardNotificationAndGesture];
    //清除键盘通知
    [self clearNotificationAndGesture];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}



#pragma mark- delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    switch (section) {
        case 0:
        {
            numberOfRows = 3;
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
            if (indexPath.row != 2) {
                heightForRow = BSTradePayoutFirstSectionCellHeight;
            }else {
                heightForRow = BSTradePayoutFirstSectionTipCellHeight;
            }
            
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
            
            if (indexPath.row != 2) {
                
                BSTradePayoutFirstSectionCell * cell = [BSTradePayoutFirstSectionCell cellForTableView:tableView];
                [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
                cellX = cell;
                
                
            }else {
                BSTradePayoutFirstSectionTipCell * cell = [BSTradePayoutFirstSectionTipCell cellForTableView:tableView];
                [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
                cellX = cell;
            }
            
            
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




#pragma mark - private method

- (void)commonInit
{
    self.title = BSLocalizedString(@"withdraw.LAP.01");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提币
- (void)firstSectionFooterViewClick {
    if ([self.model checkSendData]) {
//        //判断谷歌验证
//        if (![[BSLoginManager shareInstance] isGoogleAuthentication]) {
//            [[BSLoginManager shareInstance] showGoogleAuthenticationWithViewController:self];
//            return;
//        }
        
        if (![[BSLoginManager shareInstance] blockKeyWithViewController:self]) {
            return;
        }
        
        [self showHUDInView:self.view];
        [self.model blockSend:^(NSError *err) {
            [self hideHUD];
            if (!err) {
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                if ([err.userInfo[@"status"] integerValue] == 16) {
                    [[BSLoginManager shareInstance] showGoogleAuthenticationWithViewController:self];
                }else {
                    [self showHint:err.userInfo[@"msg"]];
                }
            }
            
        }];
    }
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
  
        _firstSectionFooterView = [[BSMineAddressSetupFooterView alloc] initWithBtnTitle:BSLocalizedString(@"confirm.the.withdraw.01") size:CGSizeMake(240.0f, BSMineAddressSetupFooterViewHeight)];
        _firstSectionFooterView.canTouch = YES;
        _firstSectionFooterView.touchEvent = @selector(firstSectionFooterViewClick);
    }
    return _firstSectionFooterView;
}


- (BSTradeModel *)model {
    if (!_model) {
        _model = [BSTradeModel new];
    }
    return _model;
}

@end
