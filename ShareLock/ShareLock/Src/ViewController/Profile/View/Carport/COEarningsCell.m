//
//  COEarningsCell.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/29.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COEarningsCell.h"

@implementation COEarningsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 添加手势
//    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Withdraw)];
//    [_typeLable addGestureRecognizer:tapGestureRec];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(COEarningsModel *)model
{
    
    _model = model;
    _dateLable.text = [NSString stringWithFormat:@"%d/%d",_model.year,_model.month];
    
    //初始化NSMutableAttributedString
    NSString *str1 = @"收益";
    NSString *str2 = [NSString stringWithFormat:@"%0.2f",model.income/100];
    NSString *str3 = @"元";

    NSString *mark = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:mark];
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:kFontSizeFour range:NSMakeRange(0, str1.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:kMainFontColor range:NSMakeRange(0, str1.length)];
    
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:kFontSizeOne range:NSMakeRange(str1.length,str2.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:kThemeColor range:NSMakeRange(str1.length,str2.length)];
    
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:kFontSizeFour range:NSMakeRange(str1.length+str2.length,str3.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:kMainFontColor range:NSMakeRange(str1.length+str2.length,str3.length)];
    
    _moneyLable.attributedText = attrStr;
//    switch (_model.status) {
//        case EarningsStatusNoWithdraw:
//        {
//            _typeLable.text = @"提现";
//            _typeLable.textColor = kThemeColor;
//            _typeLable.userInteractionEnabled = YES;
//
//        }
//            break;
//        case EarningsStatusAppleWithdraw:
//        {
//            _typeLable.text = @"提现申请中";
//            _typeLable.textColor = kMainFontColor;
//            _typeLable.userInteractionEnabled = NO;
//
//
//        }
//            break;
//        case EarningsStatusFinishWithdraw:
//        {
//            _typeLable.text = @"已提现";
//            _typeLable.textColor = kMainFontColor;
//            _typeLable.userInteractionEnabled = NO;
//
//        }
//            break;
//            
//        default:
//            break;
//    }

    
}

#pragma mark-提现
-(void)Withdraw{
    if (self.delegate && [self.delegate respondsToSelector:@selector(withdrawClicked:)]) {
        [self.delegate withdrawClicked:self];
    }}

@end
