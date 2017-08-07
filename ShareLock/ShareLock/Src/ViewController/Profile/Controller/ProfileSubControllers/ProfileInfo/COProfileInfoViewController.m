//
//  COProfileInfoViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/12.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COProfileInfoViewController.h"
#import "COProfileInfoView.h"
#import "COProfileInfoSettingViewController.h"

#import "COSettingBankInfoViewController.h"


#define WRCellViewHeight  50


@interface COProfileInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView* containerView;
@property (nonatomic, strong) COProfileInfoView*   headerView;
@property (nonatomic, strong) COProfileInfoView*   nameView;
@property (nonatomic, strong) COProfileInfoView*   wxNumberView;
@property (nonatomic, strong) COProfileInfoView*   addressView;
@property (nonatomic, strong) COProfileInfoView*   bankCardView;


@end

@implementation COProfileInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kBlcokColor;
    self.title = @"个人信息";
    
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_headerView.rightIcon sd_setImageWithURL:[NSURL URLWithString:kUserInfoModel.img_url] placeholderImage:[UIImage imageNamed:@"avatar_login"]];
    _wxNumberView.rightLabel.text = kUserInfoModel.email;
    _nameView.rightLabel.text = kUserInfoModel.nick_name;
    _addressView.rightLabel.text = kUserInfoModel.address;
    _bankCardView.rightLabel.text = kUserInfoModel.bank_name;


}

- (void)addViews
{
    [self.containerView addSubview:self.headerView];
    [self.containerView addSubview:self.nameView];
    [self.containerView addSubview:self.wxNumberView];
    [self.containerView addSubview:self.addressView];
    [self.containerView addSubview:self.bankCardView];
}

- (void)setCellFrame
{
    self.headerView.frame = CGRectMake(0, 15, kScreenWidth, 100);
    self.nameView.frame = CGRectMake(0, _headerView.frame.origin.y + self.headerView.bounds.size.height, kScreenWidth, WRCellViewHeight);
    
    self.wxNumberView.frame = CGRectMake(0, _nameView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.addressView.frame = CGRectMake(0, _wxNumberView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.bankCardView.frame = CGRectMake(0, _addressView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);

    
    self.containerView.contentSize = CGSizeMake(0, self.addressView.frame.origin.y+WRCellViewHeight+100);
}

- (void)onClickEvent
{
    __weak typeof(self) weakSelf = self;
    self.headerView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis alterHeadPortrait];
    };
    self.nameView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        
        [pThis openNewVC:pThis.nameView.leftLabel.text withRightLabel:pThis.nameView.rightLabel.text withInputType:InputType_NickName];
    };
    self.wxNumberView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis openNewVC:pThis.wxNumberView.leftLabel.text withRightLabel:pThis.wxNumberView.rightLabel.text withInputType:InputType_Email];
    };

    self.addressView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis openNewVC:pThis.addressView.leftLabel.text withRightLabel:pThis.addressView.rightLabel.text withInputType:InputType_Address];
    };
    self.bankCardView.tapBlock = ^ {
        COSettingBankInfoViewController *ctr = [[COSettingBankInfoViewController alloc]init];
        [weakSelf.navigationController pushViewController:ctr animated:YES];
    };


}


//更换头像
-(void)alterHeadPortrait{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
//    [_headerView.rightIcon setImage:newPhoto];
    [self uploadImage:newPhoto];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}





//设置个人信息
- (void)openNewVC:(NSString *)leftStr withRightLabel:(NSString *)rightStr withInputType:(InputType )inputType
{
    COProfileInfoSettingViewController *vc = [COProfileInfoSettingViewController new];
    vc.title = leftStr;
    vc.inputText = rightStr;
    vc.inputType = inputType;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark-上传照片

-(void)uploadImage:(UIImage *)image{
    [ProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:@"正在上传..." isTouched:NO inView:self.view];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    //大于100K进行压缩图片
    if (data.length>100*1024) {
        
        data = UIImageJPEGRepresentation(image, 0.1);
    }
    [[BusinessManager sharedManager].systemAccountManager requestSetUserInfoWithModel:nil fileData:data success:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0) {
            [_headerView.rightIcon sd_setImageWithURL:[NSURL URLWithString:kUserInfoModel.img_url] placeholderImage:[UIImage imageNamed:@"avatar_login"]];
        }
        [ProgressHUD showHudTipStr:dict[@"msg"]];
        
    } failure:^{
        [ProgressHUD hideProgress:self.view];
    }];
}

#pragma mark-懒加载

- (COProfileInfoView *)headerView {
    if (_headerView == nil) {
        _headerView = [[COProfileInfoView alloc] initWithLineStyle:WRCellStyleLabel_IconIndicator];
        _headerView.leftLabel.text = @"头像";
    }
    return _headerView;
}


- (COProfileInfoView *)wxNumberView {
    if (_wxNumberView == nil) {
        _wxNumberView = [[COProfileInfoView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _wxNumberView.leftLabel.text = @"邮箱";
    }

    return _wxNumberView;
}


- (COProfileInfoView *)nameView {
    if (_nameView == nil) {
        _nameView = [[COProfileInfoView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _nameView.leftLabel.text = @"昵称";
    }

    return _nameView;
}

- (COProfileInfoView *)addressView {
    if (_addressView == nil) {
        _addressView = [[COProfileInfoView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _addressView.leftLabel.text = @"联系地址";
    }

    return _addressView;
}
- (COProfileInfoView *)bankCardView {
    if (_bankCardView == nil) {
        _bankCardView = [[COProfileInfoView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _bankCardView.leftLabel.text = @"银行卡";
    }
    
    return _bankCardView;
}


@end
