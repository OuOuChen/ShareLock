//
//  COCouponCell.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/21.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCOCouponCellIdentify @"kCOCouponCellIdentify"

@interface COCouponCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *validateTime;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *describe;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@property (nonatomic ,strong) COResponseMyCouponModel *model;


@end
