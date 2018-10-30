//
//  BSTaskPublishGuideCell.m
//  BaiSongInternational
//
//  Created by 刘嵩野 on 2018/6/7.
//  Copyright © 2018年 maqihan. All rights reserved.
//

#import "BSTaskPublishGuideCell.h"
#import "UIImage+Extend.h"
#import "UITextField+Extend.h"

@interface BSTaskPublishGuideCell()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic) UIView * line;
@property (nonatomic) UILabel * titleLab;
@property (nonatomic) UITextField * textField;
@property (nonatomic) UIView * textline;
@property (nonatomic) UIImageView * imgView;
@property (nonatomic) UIButton * imgBtn;
@property (nonatomic) UIImageView * delImgView;
@property (nonatomic) UIButton * delBtn;

@property (nonatomic) BSTaskPublishGuideModel * model;
@property (nonatomic) NSIndexPath * indexPath;
@end

@implementation BSTaskPublishGuideCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID1 = @"BSTaskPublishGuideCellID";
    BSTaskPublishGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[BSTaskPublishGuideCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {
    
    
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.textline];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.imgBtn];
    [self.contentView addSubview:self.delImgView];
    [self.contentView addSubview:self.delBtn];
    
    [self layoutCustomViews];
}


- (void)layoutCustomViews {
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(@0.5);
        make.width.mas_equalTo(50);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.contentView).offset(20);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.textline.mas_top).offset(-18.5f);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [self.textline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab).offset(110);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(@0.5);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textline).offset(30);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(105);
        make.bottom.equalTo(self.contentView).offset(-30);
    }];
    
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imgView).insets(UIEdgeInsetsMake(-20, -20, -20, -20));
    }];
    
    [self.delImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.height.mas_equalTo(18);
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.delImgView).insets(UIEdgeInsetsMake(-10, -10, -10, -10));
    }];
    
}


- (void)configCellWithModel:(BSTaskPublishGuideModel *)model indexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.model = model;
    self.titleLab.text = [NSString stringWithFormat:@"%@%zd",BSLocalizedString(@"步骤"),indexPath.row+1];
    if (model.cacheImg) {
        self.imgView.image = model.cacheImg;
    }else {
        self.imgView.image = [UIImage imageNamed:@"publish_image_add.png"];
    }
    self.textField.text = model.desc;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(![textField validateSpacing:string range:range]) {
        return NO;
    }
    if (aString.length > 100) {
        return NO;
    }
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField{
    
    self.model.desc = textField.text;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField endEditing:YES];
    return YES;
}

- (void)imgBtnClick {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:BSLocalizedString(@"cancel") destructiveButtonTitle:nil  otherButtonTitles:BSLocalizedString(@"take.photos"),BSLocalizedString(@"select.from.photo.album"),nil];
    [actionSheet showInView:[self getCurrentViewController].view];
}


- (void)delBtnClick {
    if ([self.delegate respondsToSelector:@selector(delImgWithIndexPath:)]) {
        [self.delegate delImgWithIndexPath:self.indexPath];
    }
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    if (buttonIndex == 0)
    {
        //拍照
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            //没有摄像头
            return;
        }
    }else if (buttonIndex == 1){
        //从相册选择
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else {
        return;
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = sourceType;
    
    [[self getCurrentViewController] presentViewController:imagePickerController animated:YES completion:NULL];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //剪裁图片
    UIImage *image0 = [info objectForKey:UIImagePickerControllerOriginalImage];
    //需要对拍照后的照片处理 不然会出现方向颠倒
    UIImage *image = [image0 fixOrientation];
    
    self.imgView.image = image;
    self.model.cacheImg = image;
}


#pragma mark - setter && getter
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_CCC;
    }
    return _line;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
        _titleLab.textColor = BSCOLOR_000;
        _titleLab.text = BSLocalizedString(@"步骤");
    }
    return _titleLab;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = BSCOLOR_4B4B4B;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.placeholder = BSLocalizedString(@"input.content");
    }
    return _textField;
}

- (UIView *)textline
{
    if (!_textline) {
        _textline = [[UIView alloc] init];
        _textline.backgroundColor = BSCOLOR_EAEAEA;
    }
    return _textline;
}


- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.layer.borderColor = BSCOLOR_EAEAEA.CGColor;
        _imgView.layer.borderWidth = 0.5;
        _imgView.layer.masksToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.image = [UIImage imageNamed:@"publish_image_add.png"];
    }
    return _imgView;
}

- (UIButton *)imgBtn {
    if (!_imgBtn) {
        _imgBtn = [UIButton new];
        [_imgBtn addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imgBtn;
}

- (UIImageView *)delImgView {
    if (!_delImgView) {
        _delImgView = [UIImageView new];
        _delImgView.image = [UIImage imageNamed:@"publish_del.png"];
    }
    return _delImgView;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [UIButton new];
        [_delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}


@end
