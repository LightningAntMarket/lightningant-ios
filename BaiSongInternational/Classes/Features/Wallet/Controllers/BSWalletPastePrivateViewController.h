//
//  BSWalletPastePrivateViewController.h
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/2/6.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSBaseViewController.h"

/**
 *  粘贴私钥
 *  1.3改为粘贴keystore
 **/

@interface BSWalletPastePrivateViewController : BSBaseViewController
//已经不用privatekey了、用keystore
- (instancetype)initWithPrivateKey:(NSString *)privateKey;
@end
