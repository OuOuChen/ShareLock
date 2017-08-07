//
//  COPayTypeCell.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/25.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COPayTypeModel.h"
#define kCOPayTypeCellIdentify @"COPayTypeCellIdentify"

@interface COPayTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *loginIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIImageView *selectStata;


@property (nonatomic ,strong) COPayTypeModel *model;

@end
