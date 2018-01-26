//
//  BSOrderForAuctionViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/12.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderForAuctionViewController.h"

#import "BSOrderForAuctionSuccessViewController.h"
#import "BSOrderForAuctionParticipateInViewController.h"
#import "BSOrderForAuctionFailedViewController.h"

#import "BSOrderSwitchTopView.h"

@interface BSOrderForAuctionViewController ()<BSOrderSwitchTopViewDelegate>
@property (nonatomic) BSOrderSwitchTopView * topView;
@property (nonatomic) UIPageViewController  * pageViewController;
@property (nonatomic) NSArray<UIViewController *> * vcArray;
@end

@implementation BSOrderForAuctionViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark BSOrderSwitchTopViewDelegate
- (void)orderSwitchTopViewBtnClickByIndex:(NSInteger)index {
    NSInteger currentIndex =[ _vcArray indexOfObject:self.pageViewController.viewControllers[0]];
    if (currentIndex<index) {
        [self.pageViewController setViewControllers:@[self.vcArray[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }else {
        [self.pageViewController setViewControllers:@[self.vcArray[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
}


#pragma mark UIPageViewControllerDataSource && UIPageViewControllerDelegate



#pragma mark - private method

- (void)commonInit
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.pageViewController.view];
    self.title = BSLocalizedString(@"bidding.Order");
}


#pragma mark - setter && getter
- (BSOrderSwitchTopView *)topView {
    if (!_topView) {
        _topView = [[BSOrderSwitchTopView alloc]initWithType:BSOrderSwitchTopViewType_OrderAuction];
        _topView.frame = CGRectMake(0, 0, BSScreen_Width, BSOrderSwitchTopViewHeight);
        _topView.delegate =self;
    }
    return _topView;
}

-(UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        //不实现这个代理、就不会获取滚动了。
//        _pageViewController.delegate = self;
//        _pageViewController.dataSource = self;
        _pageViewController.view.frame = CGRectMake(0, BSOrderSwitchTopViewHeight,BSScreen_Width,BSScreen_Height - BSOrderSwitchTopViewHeight);
        [_pageViewController setViewControllers:@[self.vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return _pageViewController;
}

-(NSArray<UIViewController *> *)vcArray {
    if (!_vcArray) {
        BSOrderForAuctionSuccessViewController * vc1 = [BSOrderForAuctionSuccessViewController new];
        vc1.nav = self.navigationController;
        
        BSOrderForAuctionParticipateInViewController * vc2 = [BSOrderForAuctionParticipateInViewController new];
        vc2.nav = self.navigationController;
        
        BSOrderForAuctionFailedViewController * vc3 = [BSOrderForAuctionFailedViewController new];
        vc2.nav = self.navigationController;
        
        _vcArray = @[vc1,vc2,vc3];
    }
    return _vcArray;
}

@end
