//
//  COPayHistoryCell.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/31.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCOPayHistoryCelldentify @"COPayHistoryCellIdentify"


@interface COPayHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nunberID;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLable;

@property (nonatomic ,strong) COPayHistoryModel *model;


@end
