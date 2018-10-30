//
//  BSTaskPublishDescribeTableInputCell.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTaskPublishDataSource.h"


/**
 发布任务--任务描述--输入cell
 */

@protocol BSTaskPublishDescribeTableInputCellDelegage <NSObject>

- (void)didInputDescWithTextView:(UITextView *)textView;

@end

@interface BSTaskPublishDescribeTableInputCell : UITableViewCell
@property(nonatomic, weak) id<BSTaskPublishDescribeTableInputCellDelegage> delegate;
+ (instancetype)cellForTableView:(UITableView *)tableView;

- (void)configCellWithPublishHelper:(BSTaskPublishHelper *)publishHelper indexPath:(NSIndexPath *)indexPath;



@end
