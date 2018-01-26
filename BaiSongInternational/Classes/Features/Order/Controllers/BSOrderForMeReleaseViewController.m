//
//  BSOrderForMeReleaseViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2017/10/20.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderForMeReleaseViewController.h"

#import "BSGoodsDetailViewController.h"

//删除商品
static NSString * Delgood;

static NSString * GetMysend;
@interface BSOrderForMeReleaseViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic) NSIndexPath * indexPath;
@end

@implementation BSOrderForMeReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - delegate
#pragma mark  UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell_x;
    
    
    switch (indexPath.row) {

        case 0:
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}


//修改编辑按钮文字

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return BSLocalizedString(@"delete");//默认文字为 Delete
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        self.indexPath = indexPath;
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:BSLocalizedString(@"tips") message:BSLocalizedString(@"order.del.goods?") delegate:self cancelButtonTitle:BSLocalizedString(@"alert.yes") otherButtonTitles:BSLocalizedString(@"alert.no"), nil];
        
        [alert show];
        
        
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (!buttonIndex) {
        //删除
        [self delgoodWithIndexPath:self.indexPath];
    }
}



- (void)delgoodWithIndexPath:(NSIndexPath *)indexPath {
    NSString * gid = self.dataArray[indexPath.section].gid;
    NSString * url  = [NSString stringWithFormat:Delgood,gid];
    
    [self showHUDInView:self.view];
    [[BSNetWorking shareInstance] GET:url refresh:YES success:^(id json) {
        [self hideHUD];
        if ([[json objectForKey:@"status"] intValue] == 1) {
            [self.dataArray removeObjectAtIndex:indexPath.section];
            [self.tableView reloadData];
        }else {
            [self showHint:json[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [self hideHUD];
    }];
    
    
}


#pragma mark - network
- (void)loadData {
    
    NSString * url = [NSString stringWithFormat:GetMysend,self.page];
    [[BSNetWorking shareInstance]GET:url refresh:NO success:^(id json) {
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        
        
        if ([[json valueForKey:@"status"] intValue] == 1) {
            
            
            for (NSDictionary * dic in [json valueForKey:@"data"]) {
                BSOrderModel * model = [[BSOrderModel alloc]initContentWithDic:dic];
                model.showModifyBtn = YES;
                
                [self.dataArray addObject:model];
            }
            [self checkData];
            
        }else{
            //没有数据
            [self checkData];
            if (self.page != 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
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
    //tag = 10000隐藏BSOrderTableViewContentCell的横线


    [self showHUDInView:self.view];
    [self loadData];
    
}

@end
