//
//  BSGoodsDetailViewController.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailViewController.h"

#import "BSPhotosPreviewViewController.h"
#import "BSMineAddressListViewController.h"
#import "BSMineAddressSetupViewController.h"
#import "BSGoodsDetailAllAppraiseViewController.h"

#import "BSScrollBannerView.h"
#import "BSGoodsDetailBottomView.h"
#import "BSGoodsDetailPriceBottomView.h"
#import "BSDimingBackgroundView.h"
#import "BSDefaultAddressView.h"

#import "BSGoodsDetailEndTimeCell.h"
#import "BSGoodsDetailDescCell.h"
#import "BSGoodsDetailAppraiseCell.h"
#import "BSGoodsDetailContactCell.h"
#import "BSGoodsDetailPriceCell.h"
#import "BSGoodsDetailTitleCell.h"
#import "BSGoodsDetailJoinCell.h"
#import "BSGoodsDetailSendGoodsCell.h"

#import "BSGoodsDetailModel.h"
#import "UINavigationBar+Translucent.h"

#import "BSLoginManager.h"

#define scroll_offset_y 50

@interface BSGoodsDetailViewController ()<UITableViewDelegate , UITableViewDataSource , BSScrollBannerViewDelegate,BSGoodsDetailBottomViewDelegate,BSGoodsDetailPriceBottomViewDelegate,BSDefaultAddressViewDelegate,BSPhotosPreviewViewControllerDelegate,BSMineAddressListViewControllerDelegate>
{
    UIStatusBarStyle _statusBarStyle;
}
@property (strong , nonatomic) NSString           *goodsID;
@property (strong , nonatomic) BSGoodsDetailModel *detailGoods;

@property (strong , nonatomic) UITableView        *tableView;
@property (strong , nonatomic) BSScrollBannerView *bannerView;
@property (strong , nonatomic) BSGoodsDetailBottomView *bottomView;
@property (strong , nonatomic) BSGoodsDetailPriceBottomView *priceView;

@property (strong , nonatomic) BSDefaultAddressView   *defaultAddressView;

@property (weak , nonatomic) UIBarButtonItem *currentBackItem;
@property (weak , nonatomic) UIBarButtonItem *currentRightItem;

//出价参数
//@property (weak , nonatomic) BSDefaultAddress *addressModel;
@property (weak , nonatomic) NSString *price;

@end

@implementation BSGoodsDetailViewController

- (instancetype)initWithModel:(BSGoods *)model
{
    self = [super init];
    if (self) {
        self.detailGoods.goods = model;
        self.goodsID = model.gid;
    }
    return self;
}

- (instancetype)initWithGid:(NSString *)gid
{
    self = [super init];
    if (self) {
        self.goodsID = gid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];

    self.tableView.tableHeaderView = [self bannerView];
    [self reloadParallaxHeaderView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"goodsDetail_jubao_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.currentRightItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    [self loadGoods];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //打开监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //关闭监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame  = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-60);
    
    if ([UIDevice iPhoneType] == iPhoneType_iPhone_x) {
        self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-94, self.view.bounds.size.width,94);
    }else{
        self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-60, self.view.bounds.size.width,60);
    }
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

//重写返回按钮
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target
                                          action:(SEL)action
{
    UIImage *backItemImage = [[UIImage imageNamed:@"bar_back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backItemImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    self.currentBackItem = backItem;
    return backItem;
}

- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction
{
    [[BSConvenientOperationManager shareInstance] pushReportWithController:self reportID:self.detailGoods.goods.gid reportType:BSReportType_Good];
}

#pragma mark - 下载
- (void)loadGoods
{
    NSString *URLString = [@"Android/goods/detail/gid/" stringByAppendingString:self.goodsID];
    [self showHUDInView:self.view];
    
    [[BSNetWorking shareInstance] GET:URLString refresh:YES success:^(id responseObject) {
        [self hideHUD];
        
        NSInteger status = [[responseObject objectForKey:@"status"] integerValue];

        if (status == 1) {
            
            self.detailGoods = [BSGoodsDetailModel mj_objectWithKeyValues:responseObject];

            //刷新table
            [self reloadParallaxHeaderView];
            [self reloadBottomView];

            [self.tableView reloadData];

        }else{
            
        }
    } failure:^(NSError *error) {
        [self hideHUD];

    }];
}

#pragma mark - private

- (void)commonInit
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.navigationController.navigationBar.translucent = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.navigationController.navigationBar bs_setBackgroundColor:[UIColor clearColor]];
    
    _statusBarStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)reloadParallaxHeaderView
{
    self.bannerView.images = self.detailGoods.goods.images;
}

- (void)reloadBottomView
{
    self.bottomView.detailModel = self.detailGoods;
}

//用户抢 出价 将信息发送给服务器
- (void)requestUserOperation:(BSDefaultAddress *)addressModel
{
    NSString *URLString = @"Android/Join/index";
    
    NSString * privkey = [[BSLoginManager shareInstance] blockKeyWithViewController:self];
    if (!privkey) {
        return;
    }
    
    //处理空数据
    if (!self.price.length) {
        self.price = @"";
    }
    if (!addressModel.city.length) {
        addressModel.city = @"";
    }
    if (!addressModel.address.length) {
        addressModel.address = @"";
    }
    if (!addressModel.consignee.length) {
        addressModel.consignee = @"";
    }
    if (!addressModel.phone.length) {
        addressModel.phone = @"";
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.detailGoods.goods.gid,@"gid",
                                privkey,@"privkey",
                                self.price,@"userUpPrice",
                                addressModel.city,@"city",
                                addressModel.address,@"address",
                                addressModel.consignee,@"consignee",
                                addressModel.phone,@"phone",
                                nil];
    
    __weak BSGoodsDetailViewController *weakSelf = self;
    [self showHUDInView:self.view];
    
    [[BSNetWorking shareInstance] POST:URLString refresh:YES parameters:parameters success:^(id responseObject) {
        [self hideHUD];
        
        NSInteger status = [[responseObject valueForKey:@"status"] integerValue];
        NSString  *msg   = [responseObject valueForKey:@"msg"];
        if (!msg.length) {
            msg = @"出错喽！";
        }
        
        if (status == 2){
            //容币不足
            [self showHint:msg];
            
        }else if (status == 6){
            //参与成功
            [self showHint:msg];
            [weakSelf loadGoods];
            
        }else if (status == 11){
            //没有默认地址
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:BSLocalizedString(@"please.set.up.your.delivery.address") message:nil delegate:self cancelButtonTitle:BSLocalizedString(@"cancel") otherButtonTitles: BSLocalizedString(@"confirm"),nil];
            [alert show];
            
        }else if (status == 12){
            //有默认地址
            [self.defaultAddressView showAnimated:YES];
            [self.defaultAddressView configureViewWithDic:[responseObject valueForKey:@"address"]];
            
        }else if (status == 16){
            //绑定谷歌了 需要验证
            [[BSLoginManager shareInstance] showGoogleAuthenticationWithViewController:self];

        }else{
            [self showHint:msg];
        }
        
    } failure:^(NSError *error) {
        [self hideHUD];

    }];

}

#pragma mark - Notification

- (void)keyBoardWillShow:(NSNotification *)center
{
    NSDictionary *userInfo = [center userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    BSDimingBackgroundView *dimingView = [BSDimingBackgroundView dimingBackgroundView];
    keyboardFrame = [dimingView convertRect:keyboardFrame toView:nil];
    CGRect commentViewFrame;
    
    commentViewFrame = self.priceView.frame;
    
    commentViewFrame.origin.y = dimingView.bounds.size.height - (keyboardFrame.size.height + commentViewFrame.size.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    self.priceView.frame = commentViewFrame;
    
    [UIView commitAnimations];
}

- (void)keyBoardWillHide:(NSNotification *)center
{
    NSDictionary *userInfo = [center userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    CGRect commentViewFrame;
    commentViewFrame = self.priceView.frame;
    
    commentViewFrame.origin.y = BSScreen_Height;
    
    // Animate up or down
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    self.priceView.frame = commentViewFrame;
    
    [UIView commitAnimations];
}

#pragma mark - delegate
#pragma mark - BSPhotosPreviewViewController

- (NSInteger)numberOfPhotosInPhotoBrowser:(BSPhotosPreviewViewController *)photoBrowser
{
    return self.detailGoods.goods.images.count;
}

//需要反回 UIImage / NSURL 类型，其他类型报错
- (id)photoBrowser:(BSPhotosPreviewViewController *)photoBrowser photoAtIndex:(NSInteger)index
{
    return self.detailGoods.goods.images[index];
}

- (NSString *)photoBrowser:(BSPhotosPreviewViewController *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index
{
    return [NSString stringWithFormat:@"%zd/%zd",index+1,self.detailGoods.goods.images.count];
}

- (void)priceView:(BSGoodsDetailPriceBottomView *)priceView buyGoodsWithPrice:(NSString *)price
{
    self.price = price;
    
    [self.priceView dismiss];
    [BSDimingBackgroundView dismissAnimated:NO];

    [self requestUserOperation:nil];
}

- (void)bannerView:(BSScrollBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index
{
    BSPhotosPreviewViewController *previewVC = [[BSPhotosPreviewViewController alloc] init];
    previewVC.delegate = self;
    previewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:previewVC animated:YES completion:nil];
    [previewVC setCurrentPhotoIndex:index];
}

- (void)bottomView:(BSGoodsDetailBottomView *)bottomView didClickButton:(UIButton *)button
{
    NSInteger pType = self.detailGoods.goods.modetype.integerValue;
    
    if (pType == 2) {
        //一口价
        [self requestUserOperation:nil];
        
    }else if(pType == 3){
        //竞拍
        
        [BSDimingBackgroundView showAnimated:YES withView:self.priceView];
        [self.priceView showView];
        self.priceView.detailModel = self.detailGoods;
        
        [BSDimingBackgroundView dimingBackgroundView].didClickDimingBackgroundViewHandler = ^{
            [self.priceView dismiss];
            [BSDimingBackgroundView dismissAnimated:YES];
        };
    }
}

- (void)addressView:(BSDefaultAddressView *)addressView didPressStatus:(BOOL)pressStatus address:(BSDefaultAddress *)addressModel
{
    if (pressStatus) {
        //使用默认地址
        [self requestUserOperation:addressModel];
    }else{
        //从新设置地址
        BSMineAddressListViewController *addressList = [[BSMineAddressListViewController alloc] init];
        addressList.delegate = self;
        [self.navigationController pushViewController:addressList animated:YES];
    }
}

#pragma mark - table delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.detailGoods ? 8 :0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.detailGoods ? 1 :0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return [BSGoodsDetailTitleCell heightForCellWithModel:self.detailGoods.goods];
        }
            break;
        case 1:
        {
            return 160;
        }
            break;
        case 2:
        {
            PublishType type = self.detailGoods.goods.modetype.integerValue;
            return type == PublishType_Oneoff ? 0: 72;
        }
            break;
        case 3:
        {
            return [BSGoodsDetailDescCell heightForCellWithModel:self.detailGoods.goods];
        }
            break;
        case 4:
        {
            return [BSGoodsDetailJoinCell heightForCellWithModel:self.detailGoods];
        }
            break;
        case 5:
        {
            return 72;
        }
            break;
        case 6:
        {
            return 72;
        }
            break;
        case 7:
        {
            return self.detailGoods.sendGoods.count ? 362 : 0;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            BSGoodsDetailTitleCell *cell = [BSGoodsDetailTitleCell cellForTableView:tableView];
            cell.goods = self.detailGoods.goods;
            return cell;
        }
            break;
        case 1:
        {
            BSGoodsDetailPriceCell *cell = [BSGoodsDetailPriceCell cellForTableView:tableView];
            cell.goods = self.detailGoods.goods;

            return cell;
        }
            break;
        case 2:
        {
            BSGoodsDetailEndTimeCell *cell = [BSGoodsDetailEndTimeCell cellForTableView:tableView];
            cell.goods = self.detailGoods.goods;

            return cell;
        }
            break;
        case 3:
        {
            BSGoodsDetailDescCell *cell = [BSGoodsDetailDescCell cellForTableView:tableView];
            cell.goods = self.detailGoods.goods;

            return cell;
        }
            break;
        case 4:
        {
            BSGoodsDetailJoinCell *cell = [BSGoodsDetailJoinCell cellForTableView:tableView];
            cell.detailModel = self.detailGoods;
            return cell;
        }
            break;
        case 5:
        {
            BSGoodsDetailAppraiseCell *cell = [BSGoodsDetailAppraiseCell cellForTableView:tableView];
            cell.detailModel = self.detailGoods;
            return cell;
        }
            break;
        case 6:
        {
            BSGoodsDetailContactCell *cell = [BSGoodsDetailContactCell cellForTableView:tableView];
            cell.goods = self.detailGoods.goods;

            return cell;
        }
            break;
        case 7:
        {
            BSGoodsDetailSendGoodsCell *cell = [BSGoodsDetailSendGoodsCell cellForTableView:tableView];
            cell.dataArr = self.detailGoods.sendGoods;
            return cell;
        }
            break;

        default:
        {
            return nil;
        }
            break;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.row == 5) {
        if(![BSLoginManager shareInstance].isLogin) {
            [[BSLoginManager shareInstance] showLoginWithViewController:self];
            return;
        }
        //查看全部评价
        BSGoodsDetailAllAppraiseViewController *appraise = [[BSGoodsDetailAllAppraiseViewController alloc] initWithUid:self.detailGoods.goods.uid];
        [self.navigationController pushViewController:appraise animated:YES];
    }else if (indexPath.row == 6) {
        if(![BSLoginManager shareInstance].isLogin) {
            [[BSLoginManager shareInstance] showLoginWithViewController:self];
            return;
        }
        //聊天
        BSConvenientOperationManager *manager = [BSConvenientOperationManager shareInstance];
        [manager pushChatController:self phoneNumber:self.detailGoods.goods.uid conversationType:EMConversationTypeChat];
        manager.toPhoto    = self.detailGoods.goods.face;
        manager.toNickname = self.detailGoods.goods.nickname;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithWhite:1 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > scroll_offset_y) {
        CGFloat alpha = MIN(1, 1 - ((scroll_offset_y + 64 - offsetY) / 64));
        [self.navigationController.navigationBar bs_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar bs_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
    if (offsetY > scroll_offset_y) {
        //改为黑色状态了
        if (_statusBarStyle != UIStatusBarStyleDefault) {
            _statusBarStyle = UIStatusBarStyleDefault;
            [self setNeedsStatusBarAppearanceUpdate];
            
            self.currentBackItem.image = [[UIImage imageNamed:@"bar_back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.currentRightItem.image = [[UIImage imageNamed:@"goodsDetail_jubao_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.navigationItem.title = BSLocalizedString(@"details.of.commodities");

        }
    }else{
        //改为白色色状态了
        if (_statusBarStyle != UIStatusBarStyleLightContent) {
            _statusBarStyle = UIStatusBarStyleLightContent;
            [self setNeedsStatusBarAppearanceUpdate];
            
            self.currentBackItem.image = [[UIImage imageNamed:@"bar_back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.currentRightItem.image = [[UIImage imageNamed:@"goodsDetail_jubao_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.navigationItem.title = @"";
        }
    }
}

#pragma  mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //去设置地址
        BSMineAddressSetupViewController *newAddress = [[BSMineAddressSetupViewController alloc] initWithModel:nil];
        [self.navigationController pushViewController:newAddress animated:YES];
    }
}

#pragma  mark - BSMineAddressSetupViewController delegate

- (void)didSelectWithModel:(BSMineAddressModel *)model;
{
    [self requestUserOperation:nil];
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


- (BSScrollBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [BSScrollBannerView parallaxHeaderViewForSize:CGSizeMake(BSScreen_Width, BSScreen_Width * 504.0 / 750)];
        _bannerView.delegate = self;
        _bannerView.delayScroll    = 10;//10秒后滚动
        _bannerView.intervalScroll = 10;//滚动间隔10秒
    }
    return _bannerView;
}

- (BSGoodsDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BSGoodsDetailBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (BSGoodsDetailPriceBottomView *)priceView
{
    if (!_priceView) {
        _priceView = [[BSGoodsDetailPriceBottomView alloc] init];
        _priceView.frame =  CGRectMake(0, BSScreen_Height, BSScreen_Width, PriceViewDefaultHeight);
        _priceView.delegate = self;
    }
    return _priceView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BSDefaultAddressView *)defaultAddressView
{
    if (!_defaultAddressView) {
        _defaultAddressView = [[BSDefaultAddressView alloc] initWithFrame:CGRectMake(0, 0, BSScreen_Width - 60, (BSScreen_Width - 60) * 624.0/520)];
        _defaultAddressView.showCenter = YES;
        _defaultAddressView.delegate = self;
    }
    return _defaultAddressView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
