//
//  COBaseViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/5.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COBaseViewController.h"

@interface COBaseViewController ()

@end

@implementation COBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:kFontSizeOne, NSForegroundColorAttributeName:kThemeColor}];
}



-(void)showCustomNavigationBack{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    UIButton *button = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [button setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.frame = CGRectMake(0, 0, 33, 33);
    
    //监听按钮的点击
    [button addTarget:self action:@selector(onNavigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置导航栏的按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
//   self..navigationItem.leftBarButtonItem = backButton;
    // 就有滑动返回功能
}

-(void)showCustomNavigationBackWrite{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    UIButton *button = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [button setImage:[UIImage imageNamed:@"nav_back_write"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_back_write"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.frame = CGRectMake(0, 0, 33, 33);
    
    //监听按钮的点击
    [button addTarget:self action:@selector(onNavigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置导航栏的按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
    //   self..navigationItem.leftBarButtonItem = backButton;
    // 就有滑动返回功能
}

- (void)showCustomNavigationRightFirstBtnImg:(NSString *)FirstImg SecondBtnImg:(NSString *)SecondImg
{
    UIImage *searchImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@",FirstImg]];//@"searchgoods"
    searchImg = [searchImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *firstBtn = [[UIBarButtonItem alloc] initWithImage:searchImg style:UIBarButtonItemStylePlain target:self action:@selector(onNavigationRightFirstButtonClicked:)];
    
    UIImage *addImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@",SecondImg]];//@"add"
    addImg = [addImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *secondBtn = [[UIBarButtonItem alloc] initWithImage:addImg style:UIBarButtonItemStylePlain target:self action:@selector(onNavigationRightSecondButtonClicked:)];
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:secondBtn,firstBtn,nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

//显示导航栏右边的按钮
- (void)showCustomNavigationRightButtonWithTitle:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage {
    //导航栏的左边按钮
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
    if (aImage) {
        rightButton.frame = CGRectMake(0, 0, 50, 40);
        [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0,40-aImage.size.width, 0, 0)];
        
        [rightButton setImage:aImage forState:UIControlStateNormal];
    }else{
        rightButton.frame = CGRectMake(0, 0, 50, 40);
    }
    if(aTitle)
    {
        [rightButton setTitle:aTitle forState:UIControlStateNormal];
        [rightButton setTitleColor:kMainFontColor forState:UIControlStateNormal];
        rightButton.titleLabel.font = kFontSizeThree;
        [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -14)];
    }
    
    if(hImage)
    {
        [rightButton setImage:hImage forState:UIControlStateNormal];
    }
    
    //    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(onNavigationRightFirstButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

//显示导航栏右边的按钮
- (void)showCustomNavigationRightButtonWithTitleColor:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage withColor:(UIColor *)color{
    //导航栏的左边按钮
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
    if (aImage) {
        rightButton.frame = CGRectMake(0, 0, 50, 40);
        [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0,40-aImage.size.width, 0, 0)];
        
        [rightButton setImage:aImage forState:UIControlStateNormal];
    }else{
        rightButton.frame = CGRectMake(0, 0, 50, 40);
    }
    if(aTitle)
    {
        [rightButton setTitle:aTitle forState:UIControlStateNormal];
        [rightButton setTitleColor:color forState:UIControlStateNormal];
        rightButton.titleLabel.font = kFontSizeThree;
        [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -14)];
    }
    
    if(hImage)
    {
        [rightButton setImage:hImage forState:UIControlStateNormal];
    }
    
    //    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(onNavigationRightFirstButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

//导航栏中间可点击按钮
- (void)showCustomNavigationMiddeTitleButton:(NSString *) title
{
    NSString *text = title ;
    UIImage *image = [UIImage imageNamed:@"icon_up_1"] ;
    
    
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];;
    middleButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 41);
    [middleButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [middleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    middleButton.titleLabel.font = kFontSizeOne;
    [middleButton setTitle:title forState:UIControlStateNormal];
    [middleButton setImage:image forState:UIControlStateNormal];
    
    
    CGFloat imageWidth = image.size.width;
    CGSize textSize = [text sizeWithFont:middleButton.titleLabel.font  constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat textWidth = roundf(textSize.width) ;
    
    [middleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth)];
    [middleButton setImageEdgeInsets:UIEdgeInsetsMake(0 , textWidth+2, 0, -textWidth-2)];
    
    
    [middleButton addTarget:self action:@selector(onNavigationMiddleButtonTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = middleButton;
}


#pragma mark -按钮事件

//返回
- (void)onNavigationBackButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//右边第一个按钮
- (void)onNavigationRightFirstButtonClicked:(UIButton *)sender {
}

//右边第二个按钮
- (void)onNavigationRightSecondButtonClicked:(UIButton *)sender {
    
}
//中间标题按钮
- (void)onNavigationMiddleButtonTitleClicked:(UISegmentedControl *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
