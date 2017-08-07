//
//  ZXNPublicBicycleController.m
//  ZXNPublicBicycle
//
//  Created by 张小牛 on 2017/7/13.
//  Copyright © 2017年 ZXN. All rights reserved.
//

#define showViewHeight 210

#import "ZXNPublicBicycleController.h"
#import "JSBikeShowView.h"
#import "SelectableOverlay.h"
#import "ZXNLocationGaoDeManager.h"
#import "JSCenterAnnotation.h"
#import "COSearchBarEffectView.h"
#import "COLoginViewController.h"
#import "COMessageViewController.h"
#import "COProfileRootViewController.h"
#import "COMyWalletDepositViewController.h"
#import "CORealNameViewController.h"
#import "CORoutePlanView.h"
#import "COBookLockView.h"
#import "COLockOperationView.h"
#import "C0CMTAPointAnnotation.h"
#import "COUseSuccessViewController.h"

@interface ZXNPublicBicycleController ()<UIGestureRecognizerDelegate,MAMapViewDelegate,AMapNaviWalkManagerDelegate,CORoutePlanViewDelegate,COBookLockViewDelegate>{
    NSMutableArray *all_arrayList;
    ZXNLocationGaoDeManager *currentPosition;
    
    BOOL isShowView;//上部自行车信息框弹出
    BOOL isMoveView;//是否移动地图
    CLLocationCoordinate2D currentCoordinate;
    
    JSCenterAnnotation *centerAnnotaion;
    MAAnnotationView *centerAnnoView;
    
    
    NSTimer *countDownTimer;
    CGFloat angle;

}

@property (nonatomic,strong) MAMapView *mapView;
//@property (nonatomic,strong) JSBikeShowView *showView;
@property (nonatomic,strong) UIButton *btn_local;
@property (nonatomic,assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic,assign) CLLocationCoordinate2D endCoordinate;


@property (nonatomic, strong) AMapNaviPoint *startPoint;
@property (nonatomic, strong) AMapNaviPoint *endPoint;
@property (nonatomic, strong) AMapNaviWalkManager *walkManager;


/** 选中的车位*/
@property (nonatomic, assign) int status;

/** 是否是第一次定位*/
@property (nonatomic, assign) BOOL isLocation;

/** 选中的车位*/
@property (nonatomic, strong) COResponseLocksModel *selectLockModel;

/** 开锁按钮*/
@property(nonatomic, strong) UIButton *lockBtn;
/** 刷新按钮*/
@property(nonatomic, strong) UIButton *refreshBtn;
/** 路线规划view*/
@property(nonatomic, strong) CORoutePlanView *planView;
/** 取消预约视图*/
@property(nonatomic, strong) COBookLockView *bookLockView;
/** 正在用车视图*/
@property(nonatomic, strong) COLockOperationView *operationView;

/** 正在加载*/
@property(nonatomic, assign) BOOL loading;
@end

@implementation ZXNPublicBicycleController


#pragma mark-懒加载

- (CORoutePlanView *)planView {
    if (!_planView) {
        _planView = [[CORoutePlanView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 193)];
        _planView.delegate = self;
    }
    return _planView;
}
- (COBookLockView *)bookLockView {
    if (!_bookLockView) {
        _bookLockView = [[COBookLockView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 193)];
        _bookLockView.delegate = self;
    }
    return _bookLockView;
}
- (COLockOperationView *)operationView {
    if (!_operationView) {
        _operationView = [[COLockOperationView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 45)];
    }
    return _operationView;
}

- (AMapNaviWalkManager *)walkManager {
    if (!_walkManager) {
        _walkManager = [[AMapNaviWalkManager alloc]init];
    }
    _walkManager.delegate = self;

    return _walkManager;
}


- (UIButton *)lockBtn {
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _lockBtn.frame = CGRectMake((kScreenWidth-180)/2, kScreenHeight-40-30, 180, 40);
        [_lockBtn setBackgroundColor:kThemeColor];
        [_lockBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lockBtn setTitle:@"开 锁 " forState:UIControlStateNormal];
        [_lockBtn addTarget:self action:@selector(openLockClick:) forControlEvents:UIControlEventTouchUpInside];
        _lockBtn.hidden = YES;
        _lockBtn.layer.cornerRadius = 20;
        _lockBtn.layer.masksToBounds = YES;
    }
    return _lockBtn;
}

- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        

        UIImage *image = [UIImage imageNamed:@"map_ refresh"] ;
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshBtn.frame = CGRectMake(22, kScreenHeight-110, 36, 36);
        _refreshBtn.backgroundColor = [UIColor whiteColor];
        _refreshBtn.layer.masksToBounds = YES;
        _refreshBtn.layer.cornerRadius = 18;
        [_refreshBtn setImage:image forState:0];
        [_refreshBtn addTarget:self action:@selector(getLocks) forControlEvents:1 <<  6];
        _refreshBtn.hidden = YES;

    }
    return _refreshBtn;
}

#pragma mark-生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setUpView];
    //每隔一分钟调用一次
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(queryRenting) userInfo:nil repeats:YES];
    
    
    angle = 0;
    


}

-(void)startAnimation{
    self.refreshBtn.hidden = NO;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
    self.refreshBtn.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 6;
        if (_loading) {
            [self startAnimation];
        }
    }];

}

-(void)stopAnimation{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _loading = NO;
        self.refreshBtn.hidden = YES;
    });

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.walkManager.delegate = self;
    
    
    //查询租用或预订或等待上传信息的锁
    [self queryRenting];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.walkManager.delegate = nil;

}

- (void)setUpView{
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    NSString *path = [NSString stringWithFormat:@"%@/mystyle_sdk_map.data", [NSBundle mainBundle].bundlePath];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.mapView setCustomMapStyleWithWebData:data];
    [self.mapView setCustomMapStyleEnabled:YES];
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 15;
    self.mapView.showsUserLocation = true;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

    

//    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    

    
    
    //setCompassImage
    
    [self.mapView addAnnotation:centerAnnotaion];
    
    MAUserLocationRepresentation *localPoint = [[MAUserLocationRepresentation alloc] init];
    localPoint.showsHeadingIndicator = YES;
    [self.mapView updateUserLocationRepresentation:localPoint];
    //初始化步行导航
//    self.walkManager = [[AMapNaviWalkManager alloc]init];
//    self.walkManager.delegate = self;
    
    self.btn_local = [[UIButton alloc]init];
    [self.btn_local setImage:[UIImage imageNamed:@"nav_orientation"] forState:0];
    [self.btn_local addTarget:self action:@selector(local) forControlEvents:1 <<  6];
    [self.view addSubview:self.btn_local];
    [self.btn_local mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.bottom.equalTo(@-16);
    }];
    

    
    [self.view addSubview:self.refreshBtn];

    [self.view addSubview:self.planView];
    [self.view addSubview:self.bookLockView];
    [self.view addSubview:self.operationView];
    
    //设置开锁按钮
    [self.view addSubview:self.lockBtn];
    
}

- (void)local{
    //    centerAnnotaion.coordinate = currentCoordinate;
    self.mapView.showsUserLocation = true;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

#pragma mark-setup subview


//设置导航条
- (void)setupNav {
    self.title = @"iPark 爱 停 车";
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *profileButton = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [profileButton setImage:[UIImage imageNamed:@"navigationbar_list_normal"] forState:UIControlStateNormal];
    [profileButton setImage:[UIImage imageNamed:@"navigationbar_list_hl"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    profileButton.frame = CGRectMake(0, 0, 44, 44);
    //监听按钮的点击
    [profileButton addTarget:self action:@selector(profileCenter) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *profile = [[UIBarButtonItem alloc] initWithCustomView:profileButton];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, profile];
    
    // 右边按钮
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"search_down"] forState:UIControlStateHighlighted];
    searchButton.frame = CGRectMake(0, 0, 44, 44);
    [searchButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *msgButton = [[UIButton alloc] init];
    [msgButton setImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
    [msgButton setImage:[UIImage imageNamed:@"notification_down"] forState:UIControlStateHighlighted];
    msgButton.frame = CGRectMake(40, 0, 44, 44);
    [msgButton addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(0, 0, 88, 44);
//    [rightView addSubview:searchButton];
    [rightView addSubview:msgButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 这个方法是为了，不让隐藏状态栏的时候出现view上移
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // 屏幕边缘pan手势(优先级高于其他手势)
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(moveViewWithGesture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;// 屏幕左侧边缘响应
    [self.view addGestureRecognizer:leftEdgeGesture];
    // 这里是地图处理方式，遵守代理协议，实现代理方法
    leftEdgeGesture.delegate = self;
    
    // 如果是scrollView的话，下面这行代码就可以了不用遵守代理协议，实现代理方法
    //    [scrollView.panGestureRecognizer requireGestureRecognizerToFail:leftEdgeGesture];
}


#pragma mark-手势

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL result = NO;
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        result = YES;
    }
    return result;
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes {
    if (panGes.state == UIGestureRecognizerStateEnded) {
        [self profileCenter];
    }
}

#pragma mark-按钮

//搜索
- (void)searchClick {
    
    
    if (kBaseRequestModel) {
        //            COSearchViewController *vc = [[COSearchViewController alloc]init];
        //            [self.navigationController pushViewController:vc animated:YES];
        COSearchBarEffectView * search = [[COSearchBarEffectView alloc]init];
        search.effectArray = nil;
        [search show];
    }else{
        COLoginViewController *forgetPasswordVC = [[COLoginViewController alloc] init];
        [self presentViewController:forgetPasswordVC animated:YES completion:nil];
    }
}

//消息
- (void)msgClick {
    if (kBaseRequestModel) {
        COMessageViewController *vc = [[COMessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        COLoginViewController *forgetPasswordVC = [[COLoginViewController alloc] init];
        [self presentViewController:forgetPasswordVC animated:YES completion:nil];
    }
    //    TestViewController *vc = [[TestViewController alloc]init];
    //    vc.latitude = 31.976;
    //    vc.longitude = 118.71;
    //    [self.navigationController pushViewController:vc animated:YES];
    
}

// 展示个人中心
- (void)profileCenter {
    if (kBaseRequestModel) {
        [COProfileRootViewController showWithRootViewController:self];
    }else{
        COLoginViewController *forgetPasswordVC = [[COLoginViewController alloc] init];
        [self presentViewController:forgetPasswordVC animated:YES completion:nil];
    }
    
}

-(void)openLockClick:(UIButton *)sender{
    
    
    if (kBaseRequestModel) {
        if (_status == LOCK_STATUS_OPERATION) {//关锁
            [ProgressHUD shwoProgress:nil];
            [[BusinessManager sharedManager].parkingLockManager requestStopRentWithLockId:[NSString stringWithFormat:@"%d",self.selectLockModel.lock_id] order_no:self.selectLockModel.order_no success:^(NSDictionary *dict) {
                [ProgressHUD hideProgress:nil];
                if ([dict[@"ret"] intValue] == 0 ) {
                    [self queryRenting];
                    [self reloadAnnotations];
                    
                    CORechargeInfoModel *model = [CORechargeInfoModel mj_objectWithKeyValues:dict[@"recharge_info"]];
                    COUseSuccessViewController *ctr = [[COUseSuccessViewController alloc]init];
                    ctr.mode = model;
                    [self.navigationController pushViewController:ctr animated:YES];
                    
                }
                [ProgressHUD showHudTipStr:dict[@"msg"]];
            } failure:^{
                [ProgressHUD hideProgress:nil];
            }];
            
        }else{//开锁
            
            
            if (kUserInfoModel.deposited == 1) {//已经交纳押金
                
                if (kUserInfoModel.authentication == 1) {//已经实名认证
                    if (self.selectLockModel.lock_id > 0) {
                        [ProgressHUD shwoProgress:nil];
                        
                        [[BusinessManager sharedManager].parkingLockManager requestUnifiedOrderWithLockId:self.selectLockModel.lock_id estimate_time:self.planView.rentHour success:^(NSDictionary *dict) {
                            [ProgressHUD hideProgress:nil];
                            if ([dict[@"ret"] intValue] == 0 ) {
                                [self queryRenting];
                            }
                            [ProgressHUD showHudTipStr:dict[@"msg"]];
                            
                        } failure:^{
                            [ProgressHUD hideProgress:nil];
                        }];
                        
                    }else{
                        [ProgressHUD showHudTipStr:@"请选择要开的车位锁"];
                    }
                    
                }else{
                    CORealNameViewController *forgetPasswordVC = [[CORealNameViewController alloc] init];
                    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
                    //                [self presentViewController:forgetPasswordVC animated:YES completion:nil];
                }
                
            }else{//未缴纳押金
                COMyWalletDepositViewController  *ctr = [[COMyWalletDepositViewController alloc]init];
                [self.navigationController pushViewController:ctr animated:YES];
            }
            
        }

    }else{
        COLoginViewController *forgetPasswordVC = [[COLoginViewController alloc] init];
        [self presentViewController:forgetPasswordVC animated:YES completion:nil];
    }
    
    
}


#pragma mark - 添加大头针和动画
//添加大头针
- (void)addAnnotations{
    NSMutableArray *array_annotations = [[NSMutableArray alloc]init];
    
    for (COResponseLocksModel *mode in all_arrayList) {
        CLLocationCoordinate2D coor;
        coor.latitude = mode.lat;
        coor.longitude = mode.lng;
        
        C0CMTAPointAnnotation *annotation =  [[C0CMTAPointAnnotation alloc]init];
        annotation.coordinate = coor;
        annotation.title = mode.address;
        annotation.subtitle = [NSString stringWithFormat:@"%@",mode.order_no];
        annotation.mode = mode;
        [array_annotations addObject:annotation];
    }
    [self.mapView addAnnotations:array_annotations];
    isMoveView = YES;

}


#pragma mark - mapViewDelete

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    DDLogVerbose(@"移动结束");
    if (self.currentCity && !isShowView) {
        //添加标注
        [self getLocks];
    }
}


- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    if (!isMoveView) {
        //不能移动
        centerAnnotaion.lockedToScreen = NO;
    }else{
        centerAnnotaion.lockedToScreen = YES;
    }
}

- (void)mapInitComplete:(MAMapView *)mapView{
    centerAnnotaion = [[JSCenterAnnotation alloc]init];
    centerAnnotaion.coordinate = currentCoordinate;//self.mapView.centerCoordinate;
    centerAnnotaion.lockedScreenPoint = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    centerAnnotaion.lockedToScreen = YES;
    //
    [self.mapView addAnnotation:centerAnnotaion];
    [self.mapView showAnnotations:@[centerAnnotaion] animated:YES];
}
//加载大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    
    if ([annotation isMemberOfClass:[MAUserLocation class]]) {
        
        return nil;
    }
    
    if ([annotation isMemberOfClass:[JSCenterAnnotation class]]) {
        static NSString *reuseCneterid = @"myCenterId";
        MAAnnotationView *annotationView= [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseCneterid];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:reuseCneterid];
        }
        annotationView.image = [UIImage imageNamed:@"homePage_wholeAnchor"];
        annotationView.canShowCallout = NO;
        centerAnnoView = annotationView;
        return annotationView;
    }
    
    static NSString *reuseid = @"myId";
    
    MAAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseid];
    if (!annotationView) {
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:reuseid];
    }
    
    annotationView.image = [UIImage imageNamed:@"icon_taxi"];
    //    annotationView.canShowCallout = YES;
    return annotationView;
}
//单击地图
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    if (isShowView) {
        [self.btn_local setHidden:NO];
        [self reloadAnnotations];
        self.selectLockModel = nil;

    }
    
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
    if (_status != LOCK_STATUS_NORMAL) {//非未租用

        return;
    }
    
    if ([view.annotation isMemberOfClass:[MAUserLocation class]]) {
        
        return;
    }
    
    if ([view.annotation isMemberOfClass:[JSCenterAnnotation class]]) {
        
        return;
    }
    
    if (!kBaseRequestModel) {
        COLoginViewController *forgetPasswordVC = [[COLoginViewController alloc] init];
        [self presentViewController:forgetPasswordVC animated:YES completion:nil];
        return;
    }
    
    isMoveView = NO;
    self.mapView.showsUserLocation = false;

    
    //记录下点击的经纬度
    NSString *didAddress = view.annotation.title;
    
//    if (!self.showView) {
//        self.showView = [[JSBikeShowView alloc]initWithFrame:CGRectZero];
//        self.showView.backgroundColor = [UIColor whiteColor];
//        self.showView.alpha = 0.9;
//        [self.view addSubview:self.showView];
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            self.showView.frame = CGRectMake(0, 64, kScreenWidth, 0);
//        } completion:^(BOOL finished) {
//            self.showView.frame = CGRectMake(0, 64, kScreenWidth, showViewHeight);
//        }];
//    }
//    isShowView = YES;
//    [self.showView setHidden:NO];
//    [self.btn_local setHidden:YES];
//
//    ZXNWeakSelf(self)
//    self.showView.gotoOtherPlace = ^(){
//        [weakself gotoPlace];
//    };
//    
//    self.showView.label_address.text = view.annotation.title;
//    NSArray *counts = [view.annotation.subtitle componentsSeparatedByString:@"|"];
//    self.showView.label_availTotal.text = counts[0];
//    self.showView.label_emptyTotal.text = counts[1];
//    [self.planView show:view2.mode];
    C0CMTAPointAnnotation *pointAnnotation = (C0CMTAPointAnnotation *)view.annotation;
    if ([pointAnnotation isMemberOfClass:[C0CMTAPointAnnotation class]]) {
        self.selectLockModel = pointAnnotation.mode;

        [self.planView show:pointAnnotation.mode];
    }

    isShowView = YES;
    [self.btn_local setHidden:YES];


    //步行导航
    self.startCoordinate = centerAnnotaion.coordinate;
    self.endCoordinate = view.annotation.coordinate;
    
    self.startPoint = [AMapNaviPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
    
    self.endPoint = [AMapNaviPoint locationWithLatitude:self.endCoordinate.latitude longitude:self.endCoordinate.longitude];
    

    [self.walkManager calculateWalkRouteWithStartPoints:@[self.startPoint] endPoints:@[self.endPoint]];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    NSMutableArray *array_annotations = [[NSMutableArray alloc]init];
    [array_annotations addObject:centerAnnotaion];
    
    for (COResponseLocksModel *mode in all_arrayList) {
        MAPointAnnotation *annotation =  [[MAPointAnnotation alloc]init];
        if ([mode.address isEqualToString:didAddress]) {
            CLLocationCoordinate2D coor;
            coor.latitude = mode.lat;
            coor.longitude = mode.lng;
            annotation.coordinate = coor;
            annotation.title = mode.address;
            annotation.subtitle = [NSString stringWithFormat:@"%@",mode.order_no];
            [array_annotations addObject:annotation];
        }
        
    }
    
    [self.mapView addAnnotations:array_annotations];
    [self.mapView showAnnotations:array_annotations edgePadding:UIEdgeInsetsMake(300, 100, 50, 100) animated:YES];
    
}

//重新刷新视图
-(void)reloadAnnotations{

    
    [self.planView dismiss];
    
    self.mapView.zoomLevel = 15;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    [self addAnnotations];
    [self.mapView addAnnotation:centerAnnotaion];
    
    isMoveView = YES;
    self.mapView.showsUserLocation = true;

}

#pragma mark - AMapNaviWalkManagerDelegate 导航代理

- (void)walkManager:(AMapNaviWalkManager *)walkManager error:(NSError *)error
{
    DDLogVerbose(@"步行路线规划失败！");
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager onCalculateRouteFailure:(NSError *)error;
{
    DDLogVerbose(@"onCalculateRouteFailure:%@",error);
}

- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager{
    
    DDLogVerbose(@"步行路线规划成功！");
    
    if (walkManager.naviRoute == nil){
        return;
    }
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    //将路径显示到地图上
    AMapNaviRoute *aRoute = walkManager.naviRoute;
    int count = (int)[[aRoute routeCoordinates] count];
    
    //添加路径Polyline
    CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
    for (int i = 0; i < count; i++)
    {
        AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
        coords[i].latitude = [coordinate latitude];
        coords[i].longitude = [coordinate longitude];
    }
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
    
    SelectableOverlay *selectablePolyline = [[SelectableOverlay alloc] initWithOverlay:polyline];
    
    [self.mapView addOverlay:selectablePolyline];
    free(coords);
    
//    NSString *subtitle = [NSString stringWithFormat:@"长度:%ld米 | 预估时间:%ld秒 | 分段数:%ld", (long)aRoute.routeLength, (long)aRoute.routeTime, (long)aRoute.routeSegments.count];
//    DDLogVerbose(@"%@",subtitle);
//    
//    long walkMinute = walkManager.naviRoute.routeTime / 60;
//    NSString *timeDesc = @"1分钟以内";
//    if (walkMinute > 1){
//        timeDesc = [NSString stringWithFormat:@"%ld分钟",walkMinute];
//    }
//    self.showView.label_minutes.text = timeDesc;
    self.planView.distance.text = [NSString stringWithFormat:@"%.1fkm",(float)aRoute.routeLength/1000];
//    self.showView.label_distance.text = [NSString stringWithFormat:@"%.1fkm",(float)aRoute.routeLength/1000];
    
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    
    if ([overlay isKindOfClass:[SelectableOverlay class]])
    {
        SelectableOverlay * selectableOverlay = (SelectableOverlay *)overlay;
        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        
        polylineRenderer.lineWidth = 8.f;
//        polylineRenderer.strokeColor = selectableOverlay.isSelected ? selectableOverlay.selectedColor : selectableOverlay.regularColor;
        polylineRenderer.strokeColor = kRGB(45, 188, 83);

        return polylineRenderer;
    }
    
    return nil;
}
- (void)selecteOverlayWithRouteID:(NSInteger)routeID{
    
    [self.mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL *stop)
     {
         if ([overlay isKindOfClass:[SelectableOverlay class]])
         {
             SelectableOverlay *selectableOverlay = overlay;
             
             /* 获取overlay对应的renderer. */
             MAPolylineRenderer * overlayRenderer = (MAPolylineRenderer *)[self.mapView rendererForOverlay:selectableOverlay];
             
             if (selectableOverlay.routeID == routeID)
             {
                 /* 设置选中状态. */
                 selectableOverlay.selected = YES;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.selectedColor;
                 overlayRenderer.strokeColor = selectableOverlay.selectedColor;
                 
                 /* 修改overlay覆盖的顺序. */
                 [self.mapView exchangeOverlayAtIndex:idx withOverlayAtIndex:self.mapView.overlays.count - 1];
             }
             else
             {
                 /* 设置选中状态. */
                 selectableOverlay.selected = NO;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.regularColor;
                 overlayRenderer.strokeColor = selectableOverlay.regularColor;
             }
             
             [overlayRenderer glRender];
         }
     }];
}

//- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView{
//    [self getLocks];
//}



- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
//    self.mapView.showsUserLocation = true;

    if (self.currentCity &&!_isLocation) {
        NSString *city = self.currentCity;
        DDLogVerbose(@"city:%@",city);

        //添加标注
        [self getLocks];
    }
    if (self.currentCity) {
        _isLocation = YES;
    }
    
}



#pragma mark-network

//请求用户信息
-(void)loadNewData{
    [[BusinessManager sharedManager].systemAccountManager requestUserInfo:^(NSDictionary *dict) {
        if ([dict[@"ret"] intValue] == 0) {
            if (kUserInfoModel.deposited == 1 && kUserInfoModel.authentication == 0) {
                CORealNameViewController *forgetPasswordVC = [[CORealNameViewController alloc] init];
                [self.navigationController pushViewController:forgetPasswordVC animated:YES];
//                [self presentViewController:forgetPasswordVC animated:YES completion:nil];
                
            }
        }
    } failure:^{
        
    }];
}


//获取车位锁
-(void)getLocks{
    _loading = YES;
    [self startAnimation];
    CORequestLocksModel *model = [[CORequestLocksModel alloc]init];
    model.lng = [ZXNLocationGaoDeManager sharedManager].lon_gaode;
    model.lat = [ZXNLocationGaoDeManager sharedManager].lat_gaode;
    model.city = self.currentCity;
    
    
    [[BusinessManager sharedManager].parkingLockManager requestLocksWithModel:model success:^(NSDictionary *dict) {
        [self stopAnimation];
        if ([dict[@"ret"] intValue] == 0 ) {
            //            NSArray *arr = [COResponseLocksModel mj_objectArrayWithKeyValuesArray:dict[@"locks"]];
            //            [self addPointAnnotation:arr];
            all_arrayList = [COResponseLocksModel mj_objectArrayWithKeyValuesArray:dict[@"locks"]];
            ;
//            [self addAnnotations];
            [self.btn_local setHidden:NO];
            [self reloadAnnotations];
            self.selectLockModel = nil;
            
            
        }else{
            [ProgressHUD showHudTipStr:dict[@"msg"]];
        }
        
    } failure:^{
        [self stopAnimation];
    }];
}

//查询租用或预订或等待上传信息的锁
-(void)queryRenting{
    
    if (kBaseRequestModel) {
        [[BusinessManager sharedManager].parkingLockManager requestQueryRenting:^(NSDictionary *dict) {
            if ([dict[@"ret"] intValue] == 0 ) {
                
                _status = [dict[@"status"] intValue];
                
                self.selectLockModel = [COResponseLocksModel mj_objectWithKeyValues:dict[@"datas"]];
                [_lockBtn setTitle:@"开 锁 " forState:UIControlStateNormal];
                
                switch (_status) {
                    case LOCK_STATUS_NORMAL://未租用
                    {
                        _lockBtn.hidden = NO;
                        [self.btn_local setHidden:NO];
                        
//                        [self.planView dismiss];
                        [self.operationView dismiss];
                        [self.bookLockView dismiss];
                        isShowView =NO;
                        self.mapView.showsUserLocation = true;


                    }
                        break;
                    case LOCK_STATUS_OPERATION://正在租用
                    {
                        _lockBtn.hidden = NO;
                        [self.btn_local setHidden:YES];
                        
                        [_lockBtn setTitle:@"关 锁 " forState:UIControlStateNormal];
                        
                        [self.operationView show:self.selectLockModel];
                        [self.planView dismiss];
                        [self.bookLockView dismiss];
                        isShowView =YES;
                        self.mapView.showsUserLocation = false;


                        
                    }
                        break;
                    case LOCK_STATUS_BOOK://已经预订车位锁
                    {
                        _lockBtn.hidden = NO;
                        [self.btn_local setHidden:YES];

                        
                        [self.bookLockView show:self.selectLockModel];
                        [self.planView dismiss];
                        [self.operationView dismiss];
                        isShowView =YES;
                        self.mapView.showsUserLocation = false;

                    }
                        break;
                    case LOCK_STATUS_WATITING://等待锁上传开锁结果
                    {
                        _lockBtn.hidden = NO;
                        [self.btn_local setHidden:YES];

                        [_lockBtn setTitle:@"关 锁 " forState:UIControlStateNormal];
                        
                        [self updataOpenLockDataToService];
                        [self.planView dismiss];
                        [self.operationView dismiss];
                        [self.bookLockView dismiss];
                        isShowView =YES;

                        self.mapView.showsUserLocation = false;


                    }
                        break;
                        
                        
                    default:
                    {
                        _lockBtn.hidden = NO;
                        
                    }
                        break;
                }
                
            }else{
                [ProgressHUD showHudTipStr:dict[@"msg"]];
            }
        } failure:^{
            
        }];
    }
    
}


//上传开锁信息
-(void)updataOpenLockDataToService{
    [ProgressHUD shwoProgress:self.view];
    CORequestLocksResultModel *model = [[CORequestLocksResultModel alloc]init];
    //    model.resutl = 1;
    model.battery = 80;
    model.warning_code = 2;
    model.random = @"2346";
    model.lock_id = self.selectLockModel.lock_id;
    model.sign = @"23fadfadf";
    
    [[BusinessManager sharedManager].parkingLockManager requestMyCouponListWithModel:model cnn_succ:1 order_no:self.selectLockModel.order_no success:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0 ) {
            [self queryRenting];


        }
    } failure:^{
        [ProgressHUD hideProgress:self.view];
    }];
}

#pragma mark-CORoutePlanViewDelegate

//预约车位锁
- (void)searchRoute:(COResponseLocksModel *)mode{
    
    
    if (kUserInfoModel.deposited == 1) {//已经交纳押金
        
        if (kUserInfoModel.authentication == 1) {//已经实名认证
            
            if (self.selectLockModel) {
                [[BusinessManager sharedManager].parkingLockManager requestBookLockWithLockId:[NSString stringWithFormat:@"%d",mode.lock_id] success:^(NSDictionary *dict) {
                    if ([dict[@"ret"] intValue] == 0 ) {
                        [self.planView dismiss];
                        
                        //            [self.bookLockView show:mode];
                        [self queryRenting];
                        
                        
                    }
                    [ProgressHUD showHudTipStr:dict[@"msg"]];
                    
                    
                } failure:^{
                    
                }];
                
            }else{
                [ProgressHUD showHudTipStr:@"请选择要开的车位锁"];
            }
            
        }else{
            CORealNameViewController *forgetPasswordVC = [[CORealNameViewController alloc] init];
            [self.navigationController pushViewController:forgetPasswordVC animated:YES];
            //                [self presentViewController:forgetPasswordVC animated:YES completion:nil];
        }
        
        
    }else{//未缴纳押金
        COMyWalletDepositViewController  *ctr = [[COMyWalletDepositViewController alloc]init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    
    
}

#pragma mark-COBookLockViewDelegate

//取消预约
- (void)cancleBook:(COResponseLocksModel *)mode{
    [ProgressHUD shwoProgress:self.view];
    
    [[BusinessManager sharedManager].parkingLockManager requestCancelBookWithLockId:[NSString stringWithFormat:@"%d",mode.lock_id] success:^(NSDictionary *dict) {
        [ProgressHUD hideProgress:self.view];
        if ([dict[@"ret"] intValue] == 0 ) {
            [self queryRenting];

            [self.bookLockView dismiss];
            [self reloadAnnotations];
            
        }
        [ProgressHUD showHudTipStr:dict[@"msg"]];
        
    } failure:^{
        [ProgressHUD hideProgress:self.view];
    }];
    

}

@end
