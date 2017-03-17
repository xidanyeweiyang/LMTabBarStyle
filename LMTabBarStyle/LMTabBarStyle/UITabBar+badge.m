//
//  UITabBar+badge.m
//  Zhongliang
//
//  Created by 刘明 on 16/7/13.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "UITabBar+badge.h"

#define TabbarItemNums 5.0

@implementation UITabBar (badge)

- (void)lm_showBadgeOnItemIndex:(int)index{
    
    //移除之前的小红点
    [self lm_removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];
    
}


- (void)lm_showBadgeOnItemIndex:(int)index andWithNum:(NSString *)num{
    
    //移除之前的小红点
    [self lm_removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIButton *badgeView = [[UIButton alloc]init];
    badgeView.enabled = NO;
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    [badgeView setBackgroundColor:[UIColor redColor]];
    [badgeView setTitle:num forState:UIControlStateNormal];
    [badgeView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGRect tabFrame = self.frame;
    
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 20, 20);
    
    [self addSubview:badgeView];

}




- (void)lm_hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self lm_removeBadgeOnItemIndex:index];
    
}

- (void)lm_removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

@end
