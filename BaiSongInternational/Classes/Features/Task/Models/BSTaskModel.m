//
//  BSTaskModel.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/11.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskModel.h"
@implementation BSTsakCompleteUserModel

@end

@implementation BSTsakExeStepModel

@end

@implementation BSTaskModel
- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    self.Id = jsonDic[@"id"];
    
    
    if ([jsonDic[@"exe_step_arr"] isKindOfClass:[NSArray class]]) {
        //新版本用数组
        NSMutableArray * arr = [NSMutableArray new];
        for (NSDictionary * dic in jsonDic[@"exe_step_arr"]) {
            BSTsakExeStepModel * model = [[BSTsakExeStepModel alloc]initContentWithDic:dic];
            [arr addObject:model];
        }
        self.exe_step = arr.count?arr:nil;
    }else if ([jsonDic[@"exe_step"] isKindOfClass:[NSString class]] && [jsonDic[@"exe_step"] length]) {
        //老版本用字符串json
        NSArray * step_arr = [jsonDic[@"exe_step"] JSONStringToArr];
        if (step_arr) {
            NSMutableArray * arr = [NSMutableArray new];
            for (NSDictionary * dic in step_arr) {
                BSTsakExeStepModel * model = [[BSTsakExeStepModel alloc]initContentWithDic:dic];
                [arr addObject:model];
            }
            self.exe_step = arr;
        }else {
            self.exe_step = nil;
        }
        
    }else {
        self.exe_step = nil;
    }
    
    if (![jsonDic[@"check_img"] isKindOfClass:[NSArray class]]) {
        self.check_img = nil;
    }
    
    NSArray *complete_user_arr = jsonDic[@"complete_user"];
    if ([complete_user_arr isKindOfClass:[NSArray class]]) {
        NSMutableArray * userArr = [NSMutableArray new];
        for (NSDictionary * dic in complete_user_arr) {
            BSTsakCompleteUserModel * model = [[BSTsakCompleteUserModel alloc]initContentWithDic:dic];
            [userArr addObject:model];
        }
        self.complete_user = userArr;
    }
    
    
}

- (void)configModelWithDetailDic:(NSDictionary *)dic {
    NSArray *complete_user_arr = dic[@"complete_user"];
    
    if ([complete_user_arr isKindOfClass:[NSArray class]]) {
        NSMutableArray * userArr = [NSMutableArray new];
        for (NSDictionary * dic in complete_user_arr) {
            BSTsakCompleteUserModel * model = [[BSTsakCompleteUserModel alloc]initContentWithDic:dic];
            [userArr addObject:model];
        }
        self.complete_user = userArr;
    }
    self.check_img = dic[@"check_img"];
    self.check_task = dic[@"check_task"];
}

-(NSString *)url {
    if (![_url containsString:@"http"] && _url.length) {
        return [@"http://" stringByAppendingString:_url];
    }else {
        return _url;
    }
}
@end

@implementation BSTaskOrderModelForSend
- (void)setAttributes:(NSDictionary *)jsonDic{
    [super setAttributes:jsonDic];
    self.Id = jsonDic[@"id"];
    self.task_check_img = jsonDic[@"task"][@"check_img"];
    self.task_describes = jsonDic[@"task"][@"describes"];
}

@end
