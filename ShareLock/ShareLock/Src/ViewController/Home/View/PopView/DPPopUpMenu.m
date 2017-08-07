//
//  DPPopUpMenu.m
//  KSDatePickerDemo
//
//  Created by IOS on 16/7/22.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "DPPopUpMenu.h"
#import "UIColor+DPUIColor.h"
#import "DPPopUpCell.h"

@interface DPPopUpMenu()<UITableViewDelegate,UITableViewDataSource>
{
    //头部视图
    UIView *_headerView;
    //标题
    UILabel *_titleLabel;
    //tabelView
    UITableView *_menuTableView;
    UIButton *_maskView;
    
}
@end
@implementation DPPopUpMenu
- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit
{
    {
        _maskView = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    {
        _headerView=[[UIView alloc]init];
        [self addSubview:_headerView];
    }
    {
        _titleLabel=[[UILabel alloc]init];
        [_headerView addSubview:_titleLabel];
    }
    
    [self reloadAppearance];
    
}
- (void)reloadAppearance
{
    {
        _maskView.frame = [UIScreen mainScreen].bounds;
        _maskView.backgroundColor = [UIColor blackColor];
    }
    
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
    }
    {
        _headerView.backgroundColor= kThemeColor;
        
    }
    {
        _titleLabel.textColor= [UIColor whiteColor];
        _titleLabel.font= kFontSizeOne;
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    
    
}

- (void)layoutSubviews
{
    CGFloat supWidth = self.frame.size.width;
    
    
    {
        _headerView.frame = CGRectMake(0, 0, supWidth, AdaptationH(41));
        _headerView.backgroundColor= kThemeColor;
    }
    {
        _titleLabel.frame=CGRectMake(0, 0, supWidth, AdaptationH(41));
        _titleLabel.text=_titleText;
    }
    {
        _menuTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, AdaptationH(41), supWidth, AdaptationH(45)*3) style:UITableViewStylePlain];
        _menuTableView.delegate=self;
        _menuTableView.dataSource=self;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_menuTableView];
    }
    {
        [_maskView addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationH(45);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    DPPopUpCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[DPPopUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSString *str=[_dataArray objectAtIndex:indexPath.row];
    cell.myTitleLabel.text= [NSString stringWithFormat:@"%@小时",str];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str=[_dataArray objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(DPPopUpMenuCellDidClick:withStr:)]) {
        [self.delegate DPPopUpMenuCellDidClick:self withStr:str];
        [self hidden];
    }
}
- (void)show
{
    [self reloadAppearance];
    
    [self animationWithView:self duration:0.3];
    _maskView.alpha= 0;
    [UIView animateWithDuration:0.25 animations:^{
        _maskView.alpha = 0.5;
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
}
- (void)hidden
{   [_maskView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
