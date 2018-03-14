//
//  BSWalletCache.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/1.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSWalletCache.h"

#import "BSKeychain.h"
#import "BSWalletCacheMediater.h"


@interface BSWalletCache()
@property (atomic) BSWalletDataSource * dataSource;
@property (nonatomic ,copy) NSString * uid;
@end

@implementation BSWalletCache

+ (instancetype)shareInstance
{
    static BSWalletCache * _walletCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _walletCache = [[BSWalletCache alloc] init];
        [_walletCache updata];
    });
    return _walletCache;
}

- (BSWalletData *)walletData {
    [self checkUserId];
    //self.dataSourece.walletDatas 只能被替换、不存在对象操作。所以线程安全（替换的瞬间除外）
    return [self.dataSource.walletDatas firstObject];

}

- (BSWalletDataSource *)walletDataSrource {
    [self checkUserId];
    //dataSource 为atomic 无需加锁
    return self.dataSource;
}

- (void)checkUserId {
    NSString * uid = [[BSDataBaseManager shareInstance] getUserInfo].uid;
    if (![self.uid isEqualToString:uid]) {
        //账号已经更换、更新数据
        [self updata];
    }
}

- (void)updata {
    //废弃原数据
    self.dataSource.dirty = YES;
    

    NSString * uid = [[BSDataBaseManager shareInstance] getUserInfo].uid;
    self.uid = uid;
    
    BSWalletDataSource * dataSource = [BSWalletDataSource new];
    //从数据库拉取新数据
    [dataSource updata];
    self.dataSource = dataSource;
}

- (void)pushWalletData:(BSWalletData *)walletData callback:(walletCacheCallBack)callback{
    __weak typeof(self) weakSelf = self;
    [BSWalletCacheMediater keychainPushWalletData:walletData callback:^(NSError *err) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (err) {
            //添加失败
            callback(err);
        }else {
            //添加成功、检查本地是否只有一个钱包。是则设置为默认钱包
            if (strongSelf.dataSource.walletDatas.count == 1) {
                [strongSelf setDefaultWalletData:walletData callback:callback];
            }else {
                callback(err);
            }
        }
        
    }];
}

- (void)delWalletDataWithPrivateKey:(NSString *)privateKey callback:(walletCacheCallBack)callback{
    
    [BSWalletCacheMediater keychainDelWalletDataWithPrivateKey:privateKey callback:callback];
    
}

- (void)delAllWalletData:(walletCacheCallBack)callback {
    
    [BSWalletCacheMediater keychainDelAllWalletData:callback];
    
}

- (void)setDefaultWalletData:(BSWalletData *)walletData callback:(walletCacheCallBack)callback {
    
    [BSWalletCacheMediater keychainSetDefaultWalletData:walletData callback:callback];
    
}

@end



@interface BSWalletData()
@end

@implementation BSWalletData

- (NSString *)balance {
    float fbalance = [_balance floatValue];
    return [NSString stringWithFormat:@"%.4f",fbalance];
}


- (instancetype)initWithPrivateKey:(NSString *)privateKey walletName:(NSString *)walletName walletAddress:(NSString *)walletAddress
{
    self = [super init];
    if (self) {
        _privateKey = privateKey;
        _walletName = walletName.length?walletName:BSLocalizedString(@"wallet.anonymous.wallet");
        _walletAddress = walletAddress;
    }
    return self;
}

- (instancetype)initWithPrivateKey:(NSString *)privateKey walletName:(NSString *)walletName walletAddress:(NSString *)walletAddress keystore:(NSString *)keystore
{
    self = [super init];
    if (self) {
        _privateKey = privateKey;
        _walletName = walletName.length?walletName:BSLocalizedString(@"wallet.anonymous.wallet");
        _walletAddress = walletAddress;
        _keystore = keystore;
    }
    return self;
}


- (void)configWalletAddress:(NSString *)walletAddress {
    _walletAddress = walletAddress;
}

- (void)configWalletKeyStore:(NSString *)keystore {
    _keystore = keystore;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.privateKey forKey:@"privateKey"];
    [coder encodeObject:self.walletName forKey:@"walletName"];
    [coder encodeObject:self.walletAddress forKey:@"walletAddress"];
    [coder encodeObject:self.walletAddress forKey:@"keystore"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _privateKey = [coder decodeObjectForKey:@"privateKey"];
        _walletName = [coder decodeObjectForKey:@"walletName"];
        _walletAddress = [coder decodeObjectForKey:@"walletAddress"];
        _keystore = [coder decodeObjectForKey:@"keystore"];
    }
    return self;
}

- (NSString *)keystore {
    if (!_keystore.length) {
        return @"";
    }else {
        return _keystore;
    }
}

@end

@implementation BSWalletDataSource

- (void)updata {
    _walletDatas = [[BSKeychain shareInstance] wallets];
}
@end
