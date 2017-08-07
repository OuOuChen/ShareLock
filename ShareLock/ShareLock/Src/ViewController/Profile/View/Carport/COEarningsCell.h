//
//  COEarningsCell.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/29.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCOEarningsCellIdentify @"COEarningsCellIdentify"

@class COEarningsCell;
@protocol COEarningsCellDelegate <NSObject>

@optional

// 提现
- (void)withdrawClicked:(COEarningsCell *)itemCell;



@end

typedef NS_ENUM(NSInteger,EarningsStatus) {
    EarningsStatusNoWithdraw = 1,	// 可提现，
    EarningsStatusAppleWithdraw,//申请提现中
    EarningsStatusFinishWithdraw//提现已完成
};

@interface COEarningsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
//@property (weak, nonatomic) IBOutlet UILabel *typeLable;

@property (nonatomic ,strong) COEarningsModel *model;


@property (nonatomic) id <COEarningsCellDelegate> delegate;

@end
