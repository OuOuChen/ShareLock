//
//  COPayHistoryCell.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/31.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COPayHistoryCell.h"

@implementation COPayHistoryCell

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

- (void)setModel:(COPayHistoryModel *)model{
    _model = model;
    _nunberID.text = [NSString stringWithFormat:@"NO.%@",_model.order_no != nil ? _model.order_no : @""];
    _timeLable.text = _model.create_time;
    _moneyLable.text = [NSString stringWithFormat:@"%0.2f",_model.pay_amount/100];
    if (model.pay_way == PAY_TYPE_WECHAT) {
        _payTypeLable.text = @"微信";

    }else{
        _payTypeLable.text = @"支付宝";
    }

}

@end
