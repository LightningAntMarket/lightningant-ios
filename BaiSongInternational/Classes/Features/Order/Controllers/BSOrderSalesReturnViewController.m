//
//  BSOrderSalesReturnViewController.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 17/9/14.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSOrderSalesReturnViewController.h"
#import "BSLoginManager.h"


#import "IWTextView.h"
#import "BSPicUpLoadView.h"

#import "UIViewController+KeyboardCorver.h"

#import "UIViewController+DismissKeyboard.h"



static NSString * GetApplyCancleOrder = @"Android/Order/applyReturnMoney";

static NSString * GetRefuseCancleOrder = @"Android/Order/refuseCancleOrder";


//图片高度、连带photoview高度
#define UploadPicHeight  (BSScreen_Width - 40-40)/3.0f
//最大输入字符限制
#define textView_max_length 600
#define textField_max_length 60

#define textFieldH 72.0f
#define submitHeight 40.0f

@interface BSOrderSalesReturnViewController ()<UITextViewDelegate,BSPicUpLoadViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic) UIScrollView * scrollView;

/* 内容输入框 */
@property (nonatomic) IWTextView           * contentTextView;
@property (nonatomic) UIView * textViewline;

/*  标题输入框  */
@property (nonatomic) UITextField * textField;
@property (nonatomic) UIView * textFieldline;

@property (nonatomic) UILabel * tipLab;
@property (nonatomic) BSPicUpLoadView * photosView;


@property (nonatomic) UIButton * submitBtn;

@property (nonatomic) BSOrderModel * model;

@end

@implementation BSOrderSalesReturnViewController

- (instancetype)initWithModel:(BSOrderModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)dealloc {
    [self clearNotificationAndGesture];
    [self clearKeyboardNotificationAndGesture];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
    [self addNotification];
    [self setupForDismissKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.photosView.y = self.tipLab.bottom+20;
}


#pragma mark  - delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark  UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    NSString *aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ((aString.length > 0 && aString.length <= textView_max_length) || aString.length == 0) {
        
        return YES;
    }
    if (textView.text.length < textView_max_length) {
        NSInteger subLength = textView_max_length - textView.text.length;
        NSString *subString = [text substringWithRange:NSMakeRange(0, subLength)];
        textView.text = [textView.text stringByAppendingString:subString];
        
        [self refreshSubmitBtnStatus];
    }
    
    return NO;
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > textView_max_length) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, textView_max_length)];
    }
    
    [self refreshSubmitBtnStatus];
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    //禁止表情输入
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    NSString *lang = [current primaryLanguage];
    if ([lang isEqualToString:@"en-US"]) {
        if (string.length == 2) {
            return NO;
        }
    }

    
    if ([string isEmoji]) {
        return NO;
    }
    
    
    return YES;
}

-(void)textFiledEditChangedNotify:(NSNotification *)obj{

    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[[UIApplication sharedApplication]textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]||[lang isEqualToString:@"zh-Hant"]) { // 中文输入，包括繁体、简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > textField_max_length) {
                textField.text = [toBeString substringToIndex:textField_max_length];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > textField_max_length) {
            textField.text = [toBeString substringToIndex:textField_max_length];
        }
    }
    
    [self refreshSubmitBtnStatus];
}




#pragma mark BSPicUpLoadViewDelegate
- (void)freshenPhotosView {
    [self refreshSubmitBtnStatus];
    self.scrollView.contentSize = CGSizeMake(BSScreen_Width, self.photosView.frame.origin.y+self.photosView.frame.size.height+ 20 + 90);
}

- (void)photoListViewClick {
    [self hiddenKeyboard];
}



- (void)hiddenKeyboard {
    [self.contentTextView resignFirstResponder];
}



#pragma mark - event method



- (void)leftItemClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)submitBtnClick {
    
 
    [self showHUDInView:self.view];
    self.submitBtn.userInteractionEnabled = NO;
    
    
    //关闭发送按钮点击
    NSString * url;
    NSDictionary * parame;
    
    if (self.model.isBuyer) {
        url =  GetApplyCancleOrder;
        NSString * privkey = [[BSLoginManager shareInstance] blockKeyWithViewController:self];
        if (!privkey) {
            return;
        }
        parame = @{@"oid":self.model.oid,
                   @"privkey":privkey
                   };
        
    }else {
        url =  GetRefuseCancleOrder;
        parame = @{@"oid":self.model.oid};
    }

    [[BSNetWorking shareInstance] POST:url refresh:YES parameters:parame success:^(id json) {
        [self hideHUD];
        if ([json[@"status"] integerValue] == 1) {
            if (self.photosView.imageModels.count) {
                for (BSUploadModel * model in self.photosView.imageModels) {
                    [self.model.reImages addObject:model.image];
                }
            }
            
            self.model.reTitle = self.textField.text;
            self.model.reContent = self.contentTextView.text;
            
            [self showHint:BSLocalizedString(@"operation.is.successfully")];
            //成功、跳转聊天
            if (self.model.isBuyer) {
                self.model.ostate = @"5";
            }else {
                self.model.ostate = @"3";
            }
            
            [self.navigationController popViewControllerAnimated:NO];
            
            if ([self.delegate respondsToSelector:@selector(needPushMsgWithModel:)]) {
                [self.delegate needPushMsgWithModel:self.model];
            }
            
        }else {
            [self showHint:BSLocalizedString(@"failed.please.try.again")];
            self.submitBtn.userInteractionEnabled = YES;
        }
    } failure:^(NSError *error) {
        [self showHint:BSLocalizedString(@"failed.please.try.again")];
        self.submitBtn.userInteractionEnabled = YES;
    }];
    
    
    
    
    
}


#pragma mark  BSOSSManagerDelegate




#pragma  mark - private methods
- (void)commonInit {
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.model.isBuyer) {
        self.title = BSLocalizedString(@"return.01");
    }else {
        self.title = BSLocalizedString(@"decline");
    }
    
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.contentTextView];
    [self.scrollView addSubview:self.textViewline];
    
    [self.scrollView addSubview:self.textField];
    [self.scrollView addSubview:self.textFieldline];
    
    [self.scrollView addSubview:self.tipLab];
    [self.scrollView addSubview:self.photosView];
    [self.scrollView addSubview:self.submitBtn];
    
    
    [self layoutCustomViews];
}

- (void)layoutCustomViews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view).offset(-20.0f);
        make.height.mas_equalTo(200);
        make.top.equalTo(self.scrollView).offset(40.0);
    }];
    
    [self.textViewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self.contentTextView);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTextView.mas_bottom);
        make.height.mas_equalTo(textFieldH);
        
        make.left.equalTo(self.view).offset(22.0f);
        make.right.equalTo(self.view).offset(-22.0f);
    }];
    
    [self.textFieldline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textField);
        make.left.right.height.equalTo(self.textViewline);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentTextView);
        make.top.mas_equalTo(self.textFieldline.mas_bottom).offset(30.0f);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photosView.mas_bottom).offset(submitHeight);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(220.0f);
        make.height.mas_equalTo(40.0f);
    }];
}

- (void)refreshSubmitBtnStatus {
    if (self.contentTextView.text.length == 0 || self.textField.text.length == 0) {
        
        self.submitBtn.userInteractionEnabled = NO;
        self.submitBtn.alpha = 0.5;
    }else {
        
        self.submitBtn.userInteractionEnabled = YES;
        self.submitBtn.alpha = 1;
    }
}


#pragma mark- setter&& getter
-(IWTextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [IWTextView new];
        _contentTextView.font = [UIFont systemFontOfSize:14.0];
        _contentTextView.placeholder = BSLocalizedString(@"input.content");
        _contentTextView.placeholderColor = [UIColor colorWithHexString:@"C7C7CD"];
        _contentTextView.textColor = BSCOLOR_4B4B4B;
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}




- (UIView *)textViewline {
    if (!_textViewline) {
        _textViewline = [UIView new];
        _textViewline.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _textViewline;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.placeholder = BSLocalizedString(@"please.input.the.title");
        _textField.textColor = BSCOLOR_4B4B4B;
        _textField.font = [UIFont systemFontOfSize:14.0f];
    }
    return _textField;
}



- (UIView *)textFieldline {
    if (!_textFieldline) {
        _textFieldline = [UIView new];
        _textFieldline.backgroundColor = BSCOLOR_F3F3F3;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChangedNotify:)
                                                    name:TextFieadNotify
                                                  object:_textField];
    }
    return _textFieldline;
}


- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton new];
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.backgroundColor = BSCOLOR_337FDD;
        _submitBtn.layer.cornerRadius  = submitHeight/2.0f;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn setTitle:BSLocalizedString(@"submit") forState:UIControlStateNormal];
        _submitBtn.alpha = 0.5;
    }
    return _submitBtn;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.textColor = BSCOLOR_4B4B4B;
        _tipLab.font = [UIFont systemFontOfSize:16.0f];
        _tipLab.text = BSLocalizedString(@"add.pictures.up.to.6");
    }
    return _tipLab;
}

-(BSPicUpLoadView *)photosView {
    if (!_photosView) {
        _photosView = [[BSPicUpLoadView alloc] init];
        _photosView.delegate = self;
        _photosView.frame = CGRectMake(10, 307.5, BSScreen_Width-20, UploadPicHeight+20);
        _photosView.photosize = CGSizeMake(UploadPicHeight, UploadPicHeight);
        _photosView.backgroundColor = [UIColor whiteColor];
    }
    return _photosView;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.contentSize = CGSizeMake(BSScreen_Width, self.photosView.bottom+20+ 90 + textFieldH);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

@end
