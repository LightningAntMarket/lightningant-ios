//
//  BSOrderDeliveryViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/15.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderDeliveryViewController.h"


#import "UIViewController+KeyboardCorver.h"


#import "BSOrderDeliveryConsigneeInfoTableViewCell.h"
#import "BSOrderDeliveryCourierTableViewCell.h"
#import "BSMineAddressSetupFooterView.h"

#import "UIViewController+DismissKeyboard.h"

static NSString * PostSend;

//发布的
static NSString * orderSendDetail;

@interface BSOrderDeliveryViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic) UITableView * tableView;


@property (nonatomic) BSOrderModel * model;

@property (nonatomic) BSMineAddressSetupFooterView * footerView;

@end

@implementation BSOrderDeliveryViewController


#pragma mark- life cycle

- (instancetype)initWithModel:(BSOrderModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)dealloc {
    [self clearNotificationAndGesture];
    [self clearKeyboardNotificationAndGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
    [self addNotification];
    
    [self setupForDismissKeyboard];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}



#pragma mark- delegate
#pragma mark UITableViewDelegate && UITableViewDataSource
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ) {
        return [BSOrderDeliveryConsigneeInfoTableViewCell heightForCellWithModel:self.model];
    }else {
        return BSOrderDeliveryCourierTableViewCellHeight;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id cellX;
    
    if (indexPath.row == 0 ) {
        
        BSOrderDeliveryConsigneeInfoTableViewCell * cell = [BSOrderDeliveryConsigneeInfoTableViewCell cellForTableView:tableView];
        [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
        
        cellX = cell;
        

    }else {
        
        BSOrderDeliveryCourierTableViewCell * cell = [BSOrderDeliveryCourierTableViewCell cellForTableView:tableView];
        [cell configureCellForRowAtIndexPath:indexPath model:self.model tableView:tableView];
        
        cellX = cell;
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




#pragma mark - touch event 
- (void)footerClick {
    
    [self.view endEditing:YES];
    
    //检查数据 && 没有发货
    if ([self.model checkSendGoodInfo]) {
        [self sendGood];
    }else {
        [self showHint:BSLocalizedString(@"imcomplete.information")];
    };
    
    
}

#pragma mark - network
//发货
- (void)sendGood {
    NSString * url = PostSend;
    
    self.footerView.userInteractionEnabled = NO;
    
    NSDictionary * parame = @{@"company":self.model.express_company,
                              @"express":self.model.express_number,
                              @"oid":self.model.oid
                              };
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance] POST:url refresh:NO parameters:parame success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] intValue] == 1) {
            [self.model sendOver];
            
            [BSAlertView showSystemAlertViewTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"delivery.is.successfully")];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [self showHint:json[@"msg"]];
            self.footerView.userInteractionEnabled = YES;
        }
    } failure:^(NSError *error) {
        self.footerView.userInteractionEnabled = YES;
        [self hideHUD];
    }];
}

- (void)loadData {
    
    NSString * url = [NSString stringWithFormat:orderSendDetail,self.model.oid];
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance]GET:url refresh:NO success:^(id json) {
        [self hideHUD];
        if ([[json valueForKey:@"status"] intValue] == 1) {
            
            [self.model configSendDataWithDic:json[@"data"]];
            
            [self.tableView reloadData];
            
        }else{
            [self showHint:json[@"msg"]];
        }

        
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
}


#pragma mark - provate method
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.footerView.canTouch = !self.model.isSended;
    self.title = BSLocalizedString(@"shipping");
    
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
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

-(BSMineAddressSetupFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[BSMineAddressSetupFooterView alloc]initWithFrame:CGRectMake(0, 0, BSScreen_Width, 150.0f)];
        _footerView.touchEvent = @selector(footerClick);
        _footerView.btnTitle = BSLocalizedString(@"delivery");
        _footerView.btnSize = CGSizeMake(220.0f, BSMineAddressSetupFooterViewHeight);
        _footerView.canTouch = YES;
    }
    return _footerView;
}

@end
