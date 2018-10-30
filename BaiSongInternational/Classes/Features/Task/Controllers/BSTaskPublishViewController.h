//
//  BSTaskPublishViewController.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BSTaskPublishViewControllerDelegate <NSObject>
- (void)publishSuccessed;
@end

/**
 发布任务
 */
@interface BSTaskPublishViewController : UIViewController

@property (nonatomic, weak) id<BSTaskPublishViewControllerDelegate> delegate;

@end
