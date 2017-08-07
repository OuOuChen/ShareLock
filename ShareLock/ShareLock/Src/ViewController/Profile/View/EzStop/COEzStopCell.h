//
//  COEzStopCell.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/24.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCOEzStopCellIdentify @"COEzStopCellIdentify"


@interface COEzStopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNoLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UIView *line;


@property (nonatomic ,strong) COResponseEzStopModel *model;


//收益模型
@property (nonatomic ,strong) COShareEarningsModel *shareEarningsModel;

@end
