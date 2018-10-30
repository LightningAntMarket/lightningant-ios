//
//  BSTaskPublishViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishViewController.h"
#import "BSDatePickerView.h"
#import "BSTaskPublishDescribeViewController.h"
#import "BSTaskPublishGuideViewController.h"

#import "BSTaskPublishTableHeaderCell.h"
#import "BSTaskPublishEditTableCell.h"
#import "BSTaskPublishPhotosCell.h"
#import "BSTaskPublishTableFooterCell.h"

#import "UIViewController+DismissKeyboard.h"
#import "UIViewController+KeyboardCorver.h"
#import "UIViewController+FadeAnimation.h"
#import "BSLoginManager.h"

@interface BSTaskPublishViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BSDatePickerViewDelegate,BSTaskPublishPhotosCellDelete,BSTaskPublishTableFooterCellDelegate>
@property (nonatomic) UITableView * tableView;

@property (nonatomic) BSTaskPublishHelper * publishHelper;
@end

@implementation BSTaskPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
    [self addNotification];
    [self setupForDismissKeyboard];
    [self addObserverForDataSource];

    [self findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
    
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (void)dealloc {
    [self clearKeyboardNotificationAndGesture];
    //清除键盘通知
    [self clearNotificationAndGesture];
    
    [self removeObserverForDataSource];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fadeInAnimation];
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 6;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell_x;
    switch (indexPath.section) {
        case 0:
        {
            BSTaskPublishTableHeaderCell * cell = [BSTaskPublishTableHeaderCell cellForTableView:tableView];
            cell_x = cell;
        }
            break;
        case 1:
        {
            BSTaskPublishEditTableCell * cell = [BSTaskPublishEditTableCell cellForTableView:tableView];
            [cell configCellWithPublishHelper:self.publishHelper indexPath:indexPath];
            cell_x = cell;
        }
            break;
        case 2:
        {
            BSTaskPublishPhotosCell * cell = [BSTaskPublishPhotosCell cellForTableView:tableView];
            cell.delegate = self;
            
            cell_x = cell;
        }
            break;
        case 3:
        {
            BSTaskPublishTableFooterCell * cell = [BSTaskPublishTableFooterCell cellForTableView:tableView];
            [cell configCellWithPublishHelper:self.publishHelper indexPath:indexPath];
            cell.delegate = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                BSTaskPublishDescribeViewController * vc = [[BSTaskPublishDescribeViewController alloc]initWithPublishHelper:self.publishHelper];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 3:
            {
                BSDatePickerView *datePickerView = [BSDatePickerView showPickerViewWithDelegate:self];
                datePickerView.dateFormat = @"yyyy-MM-dd HH:mm";
                datePickerView.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
            }
                break;
            case 5:
            {
                BSTaskPublishGuideViewController * vc = [[BSTaskPublishGuideViewController alloc]initWithPublishHelper:self.publishHelper];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

//#pragma mark UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self.view endEditing:YES];
//}

#pragma mark BSDatePickerViewDelegate
- (void)pickerView:(BSDatePickerView *)pickerView timeValueChanged:(NSString *)timeString date:(NSDate *)date
{
    self.publishHelper.dataSource.overTime = timeString;
    self.publishHelper.dataSource.overDate = date;
    [self.tableView reloadData];
}

#pragma mark BSTaskPublishPhotosCellDelete
- (void)didFinishUploadWithImages:(NSArray *)images {
    self.publishHelper.dataSource.exampleArr = [NSMutableArray arrayWithArray:images];
}

#pragma mark BSTaskPublishTableFooterCellDelegate
- (void)payBtnClick {
    
    if (!self.publishHelper.isPayBtnCanClick) {
        return;
    }
    
    NSString * errStr = [self.publishHelper checkDataSource];
    if (errStr) {
        [self showHint:errStr];
        return;
    }
    
    if ([[BSLoginManager shareInstance]blockKeyWithViewController:self].length == 0) {
        return;
    };
    
    
    [self showHUDInView:self.view];
    __weak typeof(self) weak_self = self;
    [self.publishHelper publishDataWithSuccess:^{
        __strong typeof(weak_self) strong_self = weak_self;
        [strong_self hideHUD];
        if ([strong_self.delegate respondsToSelector:@selector(publishSuccessed)]) {
            [strong_self.delegate publishSuccessed];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:BSTaskListNeedReloadNotification object:self userInfo:nil];
        
        [strong_self dismissViewControllerAnimated:YES completion:NULL];
    } failure:^(NSError *error) {
        __strong typeof(weak_self) strong_self = weak_self;
        [strong_self hideHUD];
        if (error) {
            [strong_self showHint:error.userInfo[@"msg"]];
        }
    }];
    
}

#pragma mark - touch event
- (void)leftItemClick {
    [self.view endEditing:YES];
    [self fadeOutAnimation];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private mehtod
- (void)commonInit {
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"publish_back_button"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"";

}


//添加全局监听
- (void)addObserverForDataSource {
    unsigned int numProperty;
    objc_property_t * property_t = class_copyPropertyList([BSTaskPublishDataSource class], &numProperty);
    for (int i = 0; i < numProperty; i++) {
        NSString * str = [[NSString alloc]initWithCString:property_getName(property_t[i]) encoding:NSUTF8StringEncoding];
        [self.publishHelper.dataSource addObserver:self forKeyPath:str options:NSKeyValueObservingOptionNew context:NULL];
    }
}

//移除全局监听
- (void)removeObserverForDataSource {
    unsigned int numProperty;
    objc_property_t * property_t = class_copyPropertyList([BSTaskPublishDataSource class], &numProperty);
    for (int i = 0; i < numProperty; i++) {
        NSString * str = [[NSString alloc]initWithCString:property_getName(property_t[i]) encoding:NSUTF8StringEncoding];
        [self.publishHelper.dataSource removeObserver:self forKeyPath:str];
    }
}
//根据不同属性改变、使用不同策略
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    //发布信息校验并且是否需要更新页面
    if ([self.publishHelper checkPayBtnStatus]) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(price))] || [keyPath isEqualToString:NSStringFromSelector(@selector(prizeNum))]) {
            
        }else {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(desc))]) {
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(guideArr))]) {
        //发布模式改变、刷页面
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
}


#pragma mark - setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;;
        _tableView.backgroundColor                = [UIColor clearColor];
        _tableView.estimatedRowHeight = 60;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
    }
    return _tableView;
}


- (BSTaskPublishHelper *)publishHelper {
    if (!_publishHelper) {
        _publishHelper = [BSTaskPublishHelper helper];
    }
    return _publishHelper;
}
@end
