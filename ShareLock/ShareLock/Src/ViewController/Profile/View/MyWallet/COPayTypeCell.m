//
//  COPayTypeCell.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/25.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COPayTypeCell.h"

@implementation COPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(COPayTypeModel *)model
{
    _model = model;
    _titleName.text = _model.title;
    if (model.payType == PAY_TYPE_WECHAT) {
        _loginIcon.image = [UIImage imageNamed:@"user_deposit_wechat"];
    }else{
        _loginIcon.image = [UIImage imageNamed:@"user_deposit_alipay"];
    }
    
}

@end
