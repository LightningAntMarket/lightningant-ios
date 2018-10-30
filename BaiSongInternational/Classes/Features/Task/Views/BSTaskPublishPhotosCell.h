//
//  BSTaskPublishPhotosCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/8.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTaskPublishDataSource.h"


@protocol BSTaskPublishPhotosCellDelete <NSObject>

- (void)didFinishUploadWithImages:(NSArray *)images;

@end

@interface BSTaskPublishPhotosCell : UITableViewCell
@property (nonatomic ,weak) id<BSTaskPublishPhotosCellDelete> delegate;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
