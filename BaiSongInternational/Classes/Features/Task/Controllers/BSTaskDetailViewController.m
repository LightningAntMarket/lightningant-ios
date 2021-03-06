//
//  BSTaskDetailViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskDetailViewController.h"
#import "BSTaskDetailIntroTableViewCell.h"
#import "BSMineAddressSetupFooterView.h"
#import "BSTaskDetailAuditExampleCell.h"
#import "BSTaskDetailGuideTableViewCell.h"
#import "BSTaskDetailGuideNoPicTableViewCell.h"
#import "BSTaskDetailTipCell.h"
#import "BSTaskDetailDoneUserCell.h"
#import "BSTaskOrderCommitViewController.h"

#import "BSUMSocialConfig.h"
#import "BSLoginManager.h"



@interface BSTaskDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BSTaskOrderCommitViewControllerDelegate>
@property (nonatomic) UITableView * tableView;
@property (nonatomic) BSMineAddressSetupFooterView * sectionFooterView;

@property (nonatomic, copy) NSString * taskId;
@property (nonatomic) NSArray *sectionHeadeArr;
@property (nonatomic) BSTaskModel * model;

@property (nonatomic) NSString * self_uid;
@end

@implementation BSTaskDetailViewController

- (instancetype)initWithTaskModel:(BSTaskModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
        self.taskId = model.Id;
    }
    return self;
}

- (instancetype)initWithTaskId:(NSString *)taskId;
{
    self = [super init];
    if (self) {
        self.taskId = taskId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
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


#pragma mark - Delegate
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
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
            //验证
            if (self.model.check_img.count) {
                return 1;
            }else {
                return 0;
            }
        }
            break;
        case 2:
        {
            return self.model.exe_step.count;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
        case 4:
        {
            if (self.model.complete_user.count) {
                return 1;
            }else {
                return 0;
            }
            
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
            BSTaskDetailIntroTableViewCell * cell = [BSTaskDetailIntroTableViewCell cellForTableView:tableView];
            [cell configCellWithModel:self.model indexPath:indexPath];
            cell_x = cell;
        }
            break;
        case 1:
        {
            BSTaskDetailAuditExampleCell * cell = [BSTaskDetailAuditExampleCell cellForTableView:tableView];
            [cell configCellWithModel:self.model indexPath:indexPath];
            cell_x = cell;
        }
            break;
        case 2:
        {
            BSTsakExeStepModel * model = self.model.exe_step[indexPath.row];
            if (model.img.length) {
                BSTaskDetailGuideTableViewCell * cell = [BSTaskDetailGuideTableViewCell cellForTableView:tableView];
                [cell configCellWithModel:model indexPath:indexPath];
                cell_x = cell;
            }else {
                BSTaskDetailGuideNoPicTableViewCell * cell = [BSTaskDetailGuideNoPicTableViewCell cellForTableView:tableView];
                [cell configCellWithModel:model indexPath:indexPath];
                cell_x = cell;
            }

            
        }
            break;
        case 3:
        {
            BSTaskDetailTipCell * cell = [BSTaskDetailTipCell cellForTableView:tableView];
            cell_x = cell;
        }
            break;
        case 4:
        {
            BSTaskDetailDoneUserCell * cell = [BSTaskDetailDoneUserCell cellForTableView:tableView];
            [cell configCellWithModel:self.model indexPath:indexPath];
            cell_x = cell;
        }
            break;

        default:
            break;
    }
    return cell_x;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        
        if ([self.model.pub_id isEqualToString:self.self_uid] || !self.model.check_task) {
            //自己的任务
            return [UIView new];
        }
        return self.sectionFooterView;
    }if (section == 2) {
        return [UIView new];
    }else {
        return [UIView new];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [UIView new];
    }if(section == 1 && !self.model.check_img.count) {
        //验证
        return [UIView new];
    }else if (section == 4 &&!self.model.complete_user.count) {
        return [UIView new];
    }else {
        return self.sectionHeadeArr[section-1];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        if ([self.model.pub_id isEqualToString:self.self_uid] || !self.model.check_task) {
            //自己的任务
            return 40;
        }
        return 120;
    }if (section == 2) {
        return 15;
    }else {
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if(section == 1 && !self.model.check_img.count) {
        //验证
        return CGFLOAT_MIN;
    }else if (section == 4 &&!self.model.complete_user.count) {
        return CGFLOAT_MIN;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma  mark BSTaskOrderCommitViewControllerDelegate
- (void)commitIsSuccessWithTsakId:(NSString *)taskId {

    self.model.check_task = @"20";
    
    [self configFooterBtn];
}

- (void)appeptTask {
    NSString * url = POSTAcceptTask;
    
    NSDictionary * parmaet = @{
                                      @"task_id":self.taskId,
                                      @"pub_id":self.model.pub_id
                                      };
    
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance] POST:url refresh:YES parameters:parmaet success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] integerValue] == 1) {
            
            self.model.check_task = @"10";
            [self configFooterBtn];
            NSInteger accept = [self.model.accept_num integerValue];
            self.model.accept_num = [NSString stringWithFormat:@"%zd",++accept];
            [self.tableView reloadData];
        }else {
            [self showHint:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
}

- (void)configFooterBtn {
    
    switch ([self.model.check_task integerValue]) {
        case 10:
        {
            //提交审核
            self.sectionFooterView.btnTitle = BSLocalizedString(@"LN_localizable_2.0_71");
            self.sectionFooterView.canTouch = YES;
        }
            break;
        case 20:
        {
            //重新提交
            self.sectionFooterView.btnTitle = BSLocalizedString(@"LN_localizable_2.0_73");
            self.sectionFooterView.canTouch = YES;
        }
            break;
        case 30:
        {
            //已完成
            self.sectionFooterView.btnTitle = BSLocalizedString(@"LN_localizable_2.0_69");
            self.sectionFooterView.canTouch = NO;
        }
            break;
        case 40:
        {
            //接单
            self.sectionFooterView.btnTitle = BSLocalizedString(@"LN_localizable_2.0_82");
            self.sectionFooterView.canTouch = YES;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - touch event
- (void)footerViewClick {
    if (![[BSLoginManager shareInstance] isLogin]) {
        UIViewController *currentVC = self;
        [[BSLoginManager shareInstance] showLoginWithViewController:currentVC];
        
        return;
    }
    switch ([self.model.check_task integerValue]) {
        case 10:
        {
            //提交审核
            BSTaskOrderCommitViewController * vc = [[BSTaskOrderCommitViewController alloc]initWithTaskId:self.taskId];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 20:
        {
            //重新提交
            BSTaskOrderCommitViewController * vc = [[BSTaskOrderCommitViewController alloc]initWithTaskId:self.taskId];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 30:
        {
            //已完成
        }
            break;
        case 40:
        {
            //接单
            [self appeptTask];
        }
            break;
            
        default:
            break;
    }
}

- (void)rightItemClick {
    [[BSUMSocialConfig shareInstance] showUMShareViewController:self title:BSLocalizedString(@"LN_localizable_2.0_126") content:self.model.describes imgURL:@"https://91baisong.com/bs_cn/Public/CssJs/logo.png" LinkURL:[NSString stringWithFormat:@"%@/home/task/index/task_id/%@",[[NSUserDefaults standardUserDefaults] APPDomainURL],self.model.Id] shareType:BSShareType_Image resultHandler:^(id response) {
        
    }];
}

- (void)loadData {
    NSString * url = [NSString stringWithFormat:GETTaskDetail,self.taskId];
    
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        if ([json[@"status"] integerValue] == 1) {
            
            if (self.model) {
                //有初始数据
                [self.model configModelWithDetailDic:json[@"data"]];
            }else {
                //没有初始数据
                self.model = [[BSTaskModel alloc]initContentWithDic:json[@"data"]];
            }
            
            [self configFooterBtn];
            
            [self.tableView reloadData];
            
        }else if ([json[@"status"] integerValue] == 205) {
            
            
            NSString *title = BSLocalizedString(@"LN_localizable_2.0_119");
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:BSLocalizedString(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
     
            
            [alert addAction:action1];
 
            UIViewController *currentVC = [self currentViewController];
            [currentVC presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - private mehtod
- (void)commonInit {
    
    [self.view addSubview:self.tableView];
    
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"task_detail_share.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationController.navigationBar.tintColor = BSCOLOR_000;
    
    if (self.model) {
        [self.tableView reloadData];
    }
    
    [self loadData];
}


#pragma mark - setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;;
        _tableView.backgroundColor                = [UIColor clearColor];
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
    }
    return _tableView;
}

- (BSMineAddressSetupFooterView *)sectionFooterView {
    if (!_sectionFooterView) {
        _sectionFooterView = [[BSMineAddressSetupFooterView alloc]initWithBtnTitle:BSLocalizedString(@"")];
//        _sectionFooterView.touchEvent = @selector(footerViewClick);
        [_sectionFooterView addTarget:self event:@selector(footerViewClick)];

        _sectionFooterView.canTouch = YES;
        
    }
    return _sectionFooterView;
}

- (NSArray *)sectionHeadeArr {
    if (!_sectionHeadeArr) {
        NSMutableArray * mArr = [NSMutableArray new];
        NSArray *titleArr = @[BSLocalizedString(@"LN_localizable_2.0_06"),BSLocalizedString(@"LN_localizable_2.0_08"),BSLocalizedString(@"LN_localizable_2.0_09"),BSLocalizedString(@"LN_localizable_2.0_11")];
        for (int i = 0; i <titleArr.count ; i++) {
            UIView * headerView = [UIView new];
            UILabel * titleLab = [UILabel new];
            [headerView addSubview:titleLab];
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headerView);
                make.left.equalTo(headerView).offset(20);
            }];
            titleLab.font = [UIFont systemFontOfSize:18];
            titleLab.textColor = BSCOLOR_000;
            titleLab.text = titleArr[i];
            [mArr addObject:headerView];
        }
        _sectionHeadeArr = [NSArray arrayWithArray:mArr];
    }
    return _sectionHeadeArr;
}

- (NSString *)self_uid {
    if (!_self_uid) {
        BSUser * user = [[BSDataBaseManager shareInstance] getUserInfo];
        _self_uid = user.uid;
    }
    return _self_uid;
}
@end
