//
//  COProfileCell.h
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <UIKit/UIKit.h>
@class COProfileItemModel;


@interface COProfileCell : UITableViewCell

/** item */
@property (nonatomic, strong) COProfileItemModel *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end