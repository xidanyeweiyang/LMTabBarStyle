//
//  LMTarBarBigButton.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/15.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMTarBarBigButton.h"
#import "LMBigButton.h"

@interface LMTarBarBigButton ()

@property (nonatomic, strong) LMBigButton *bigButton;

@end

@implementation LMTarBarBigButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self addSubview:self.bigButton];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    CGFloat width = frame.size.width / self.items.count - 1;
    self.bigButton.frame = CGRectInset(frame, 2 * width, 0);
    [self bringSubviewToFront:self.bigButton];
}

- (void)bigButtonClick{
    
    NSLog(@"点击了大按钮");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (self.clipsToBounds || (self.alpha == 0) || self.hidden) {
        return nil;
    }
    
    CGPoint buttonPoint = [self convertPoint:point toView:self.bigButton.titleLabel];
    
    if ([self.bigButton.titleLabel pointInside:buttonPoint withEvent:event]) {
        
        return nil;
    }else{
        return [super hitTest:point withEvent:event];
    }
    
}

- (LMBigButton *)bigButton{
    
    if (!_bigButton) {
        _bigButton = [[LMBigButton alloc] init];
        [_bigButton setImage:[UIImage imageNamed:@"摄影机图标_点击前"] forState:UIControlStateNormal];
        [_bigButton setImage:[UIImage imageNamed:@"摄影机图标_点击后"] forState:UIControlStateHighlighted];
        [_bigButton addTarget:self action:@selector(bigButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bigButton;
}

@end
