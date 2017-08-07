//
//  COEzStopCell.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/24.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COEzStopCell.h"

@implementation COEzStopCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    //加一条底部的灰色线条
    CALayer *bottomLineLayer = [CALayer layer];
    bottomLineLayer.borderWidth = kLineHeight;
    bottomLineLayer.borderColor = kLineColor.CGColor;
    bottomLineLayer.frame = CGRectMake(0, 54, kScreenWidth, 1);
    [self.layer addSublayer:bottomLineLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(COResponseEzStopModel *)model{
    _model = model;
    _orderNoLable.text = [NSString stringWithFormat:@"NO.%@",_model.lock_id != nil ? _model.lock_id : @""];
    _timeLable.text = _model.rent_time;
    _moneyLable.text = [NSString stringWithFormat:@"%0.2f",_model.real_amount/100];
    
}

//收益模型
- (void)setShareEarningsModel:(COShareEarningsModel *)shareEarningsModel{
    _shareEarningsModel = shareEarningsModel;
//    _orderNoLable.text = [NSString stringWithFormat:@"NO.%@",_model.lock_id != nil ? _model.lock_id : @""];
    _timeLable.text = _shareEarningsModel.rent_time;
    _moneyLable.text = [NSString stringWithFormat:@"%0.2f",_shareEarningsModel.sharer_income/100];
    
}

@end
