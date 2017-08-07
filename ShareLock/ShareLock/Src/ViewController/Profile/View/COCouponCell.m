//
//  COCouponCell.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/21.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COCouponCell.h"

@implementation COCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
    // Initialization code
}

-(void)setupView{
    _name.font = kFontSizeThree;
    _name.textColor = kMainFontColor;
    _describe.font = kFontSizeFour;
    _describe.textColor = kMinorFontColor;
    _validateTime.font = kFontSizeFour;
    _validateTime.textColor = kGrayColor;
    _lineView.backgroundColor = kThemeColor;
    self.backgroundColor =  kBlcokColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(COResponseMyCouponModel *)model
{
    _model = model;
    
    _name.text = _model.mark;
    _validateTime.text = [NSString stringWithFormat:@"有效期至%@",_model.validate_end];
    
    //初始化NSMutableAttributedString
    NSString *str1 = [NSString stringWithFormat:@"%0.2f",model.amount/100];
    NSString *str2 = @"元";
    NSString *mark = [NSString stringWithFormat:@"%@%@",str1,str2];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:mark];
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, str1.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:kThemeColor range:NSMakeRange(0, str1.length)];
    
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:kFontSizeFour range:NSMakeRange(str1.length,str2.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:kGrayColor range:NSMakeRange(str1.length,str2.length)];

    _money.attributedText = attrStr;
    

    
}


@end
