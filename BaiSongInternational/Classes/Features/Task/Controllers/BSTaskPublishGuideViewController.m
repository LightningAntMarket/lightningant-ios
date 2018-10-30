//
//  BSTaskPublishGuideViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/7.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishGuideViewController.h"

#import "BSTaskPublishGuideTableHeaderCell.h"
#import "BSTaskPublishGuideCell.h"
#import "BSTaskPublishGuideFooterView.h"

#import "UIViewController+DismissKeyboard.h"
#import "UIViewController+KeyboardCorver.h"

@interface BSTaskPublishGuideViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BSTaskPublishGuideCellDelegate>
@property (nonatomic) UITableView * tableView;

@property (nonatomic) BSTaskPublishHelper * publishHelper;
/**
    当前页面的数据源
 */
@property (nonatomic) NSMutableArray<BSTaskPublishGuideModel *> * guideArr;
@end

@implementation BSTaskPublishGuideViewController

- (instancetype)initWithPublishHelper:(BSTaskPublishHelper *)publishHelper
{
    self = [super init];
    if (self) {
        self.publishHelper = publishHelper;
        
        self.guideArr = [[NSMutableArray alloc]initWithArray:publishHelper.dataSource.guideArr];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Delegate
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0?1:self.guideArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell_x;
    switch (indexPath.section) {
        case 0:
        {
            BSTaskPublishGuideTableHeaderCell * cell = [BSTaskPublishGuideTableHeaderCell cellForTableView:tableView];
            cell_x = cell;
        }
            break;
        case 1:
        {
            BSTaskPublishGuideCell * cell = [BSTaskPublishGuideCell cellForTableView:tableView];
            cell.delegate = self;
            [cell configCellWithModel:self.guideArr[indexPath.row] indexPath:indexPath];
            cell_x = cell;
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


#pragma mark - touch event
- (void)rightItemClick {
    if (![self.publishHelper checkGuideWithArr:self.guideArr]) {
        [self showHint:[NSString stringWithFormat:BSLocalizedString(@"步骤说明限制%zd-%zd个字符"),self.publishHelper.guideDescMinCount,self.publishHelper.guideDescMaxCount]];
        return;
    }
    
    [self showHUDInView:self.view];
    __weak typeof(self) weak_self = self;
    [self.publishHelper upLoadImgWithGuideArr:self.guideArr completionHandler:^(NSMutableArray<BSTaskPublishGuideModel *> *arr) {
        __strong typeof(weak_self) strong_self = weak_self;
        [self hideHUD];
        
        if (arr) {
            strong_self.publishHelper.dataSource.guideArr = arr;
            [strong_self.navigationController popViewControllerAnimated:YES];
        }else {
            //上传失败
            [strong_self showHint:BSLocalizedString(@"上传失败、请重试？？")];
        }
    }];
}

- (void)footerViewClicked {
    
    [self.guideArr addObject:[BSTaskPublishGuideModel new]];
    if (self.guideArr.count == self.publishHelper.guideArrMaxCount) {
        self.tableView.tableFooterView.hidden = YES;
    }
    [self.tableView reloadData];
}

- (void)delImgWithIndexPath:(NSIndexPath *)indexPath {
    [self.guideArr removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    if (self.guideArr.count < self.publishHelper.guideArrMaxCount) {
        self.tableView.tableFooterView.hidden = NO;
    }
    [self.tableView reloadData];
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
        
        BSTaskPublishGuideFooterView * footer = [[BSTaskPublishGuideFooterView alloc]initWithFrame:CGRectMake(0, 0, BSScreen_Width, 50)];
        
        UITapGestureRecognizer *r5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(footerViewClicked)];
        r5.numberOfTapsRequired = 1;
        [footer addGestureRecognizer:r5];
        
       
        _tableView.tableFooterView = footer;
    }
    return _tableView;
}

@end
