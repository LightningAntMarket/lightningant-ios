//
//  BSTaskPublishGuideViewController.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/7.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSBaseViewController.h"
#import "BSTaskPublishDataSource.h"

/**
 任务发布--流程说明
 由于存在左滑退出以及完成按钮、页面的上传策略为点击完成是全部上传
 */

@interface BSTaskPublishGuideViewController : BSBaseViewController

- (instancetype)initWithPublishHelper:(BSTaskPublishHelper *)publishHelper;
@end
