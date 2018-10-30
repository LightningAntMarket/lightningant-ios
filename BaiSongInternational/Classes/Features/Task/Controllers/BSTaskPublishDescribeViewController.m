//
//  BSTaskPublishDescribeViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishDescribeViewController.h"

#import "BSTaskPublishDescribeTableHeaderCell.h"
#import "BSTaskPublishDescribeTableInputCell.h"

#import "UIViewController+DismissKeyboard.h"
#import "UIViewController+KeyboardCorver.h"

@interface BSTaskPublishDescribeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BSTaskPublishDescribeTableInputCellDelegage>
@property (nonatomic) UITableView * tableView;
@property (nonatomic) BSTaskPublishHelper * publishHelper;

@property (nonatomic, copy) NSString * desc;
@end

@implementation BSTaskPublishDescribeViewController

- (instancetype)initWithPublishHelper:(BSTaskPublishHelper *)publishHelper
{
    self = [super init];
    if (self) {
        self.publishHelper = publishHelper;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
    [self setupForDismissKeyboard];
    
    [self commmonInit];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Delegate
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell_x;
    switch (indexPath.section) {
        case 0:
        {
            BSTaskPublishDescribeTableHeaderCell * cell = [BSTaskPublishDescribeTableHeaderCell cellForTableView:tableView];
            cell_x = cell;
        }
            break;
        case 1:
        {
            BSTaskPublishDescribeTableInputCell * cell = [BSTaskPublishDescribeTableInputCell cellForTableView:tableView];
            cell.delegate = self;
            [cell configCellWithPublishHelper:self.publishHelper indexPath:indexPath];
            cell_x = cell;
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    return cell_x;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}



#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark BSTaskPublishDescribeTableInputCellDelegate
- (void)didInputDescWithTextView:(UITextView *)textView {
    self.desc = textView.text;
}

#pragma mark - touch event
- (void)rightItemClick {
    if (self.desc.length < self.publishHelper.descMinCount) {
        [self showHint:[NSString stringWithFormat:BSLocalizedString(@"app_alert_01"),BSLocalizedString(@"LN_localizable_2.0_37"),[NSString stringWithFormat:@"%zd-%zd",self.publishHelper.descMinCount,self.publishHelper.descMaxCount]]];
        return;
    }
    
    self.publishHelper.dataSource.desc = self.desc;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private mehtod
- (void)commmonInit {
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:BSLocalizedString(@"done") style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

#pragma mark - setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;;
        _tableView.backgroundColor                = [UIColor clearColor];
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}


@end
