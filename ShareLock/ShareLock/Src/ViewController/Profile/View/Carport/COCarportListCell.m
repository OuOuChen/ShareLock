//
//  COCarportListCell.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/22.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COCarportListCell.h"

@implementation COCarportListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(COViewShareModel *)model
{
    _model = model;
    
    _lockIdLable.text =   [NSString stringWithFormat:@"NO.%@",_model.lock_id != nil ? _model.lock_id : @""];
    _applyTimeLable.text = [NSString stringWithFormat:@"申请时间:%@",_model.apply_time];
    _rentLable.text = [NSString stringWithFormat:@"基础价格:%0.2f元/小时",_model.rent/100];
    _rentHotLable.text = [NSString stringWithFormat:@"高峰时间:%0.1f倍",_model.hot_time_rate];
    _rentLowLable.text = [NSString stringWithFormat:@"低峰时间:%0.1f元倍",_model.cold_time_rate];
    switch (model.status) {
        case ShareStatusSubmit:
        {
            _statusLable.text = @"已经提交给平台";
        }
            break;
        case ShareStatusWokring:
        {
            _statusLable.text = @"共享中";
        }
            break;
        case ShareStatusSuspend:
        {
            _statusLable.text = @"暂停共享";
        }
            break;
            
        default:
            break;
    }
    
    
}

@end
