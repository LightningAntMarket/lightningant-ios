//
//  AppDelegate.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/22.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "AppDelegate.h"
#import "BSRootViewControllerConfig.h"
#import "BSUMSocialConfig.h"
#import "BSGeTuiConfig.h"
#import "BSHuanXinConfig.h"
#import "BSAPPSetConfig.h"
#import "BSLoginManager.h"
#import "BSUnreadMessageManager.h"
#import "BSGroupChatInvViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    application.statusBarHidden = NO;

    //工程配置
    [self configureProjectApplication:application options:launchOptions];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 配置工程文件

- (void)configureProjectApplication:(UIApplication *)application options:(NSDictionary *)launchOptions
{
    //初始化app设置
    [[BSAPPSetConfig shareInstance] setupAPP];

    //控制器
    self.window.rootViewController = [BSRootViewControllerConfig shareInstance].tabBarController;
    
    //友盟
    [BSUMSocialConfig shareInstance];

    //环信
    [[BSHuanXinConfig shareInstance] setupHuanXinApplication:application Options:launchOptions];

    //个推 应该在环信后面
    [[BSGeTuiConfig shareInstance] setupGeTuiApplication:application Options:launchOptions];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
    }
    return result;
}

#pragma mark - 远程通知(推送)回调
//注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

//注册成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description]
                       stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *GTDeviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"========deviceToken:%@",GTDeviceToken);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //传给环信 同步方法会阻塞进程
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
        //传给个推
        [GeTuiSdk registerDeviceToken:GTDeviceToken];
    });
}

#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[BSUnreadMessageManager shareInstance] getAllUnreadMessage];
    
    //判断剪切板 是否需要加群
    [BSGroupChatInvViewController checkPBoardInfo];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
