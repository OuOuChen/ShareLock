//
//  COCarportListCell.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCOCarportListCellIdentify @"COCarportListCellIdentify"


typedef NS_ENUM(NSInteger, ShareStatus) {
    ShareStatusSubmit = 1,	// 已经提交给平台
    ShareStatusWokring,//共享中
    ShareStatusSuspend//暂停共享
};


@interface COCarportListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lockIdLable;
@property (weak, nonatomic) IBOutlet UILabel *rentLable;
@property (weak, nonatomic) IBOutlet UILabel *rentHotLable;
@property (weak, nonatomic) IBOutlet UILabel *rentLowLable;
@property (weak, nonatomic) IBOutlet UILabel *applyTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;


@property (nonatomic ,strong) COViewShareModel *model;


@end
