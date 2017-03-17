//
//  LMBigButton.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/15.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMBigButton.h"

@implementation LMBigButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self setTitle:@"大号按钮" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        self.imageView.contentMode = UIViewContentModeCenter;

    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = 0;
    frame.size.width = self.frame.size.width;
    frame.size.height = 16;
    frame.origin.y = self.frame.size.height - frame.size.height;
    self.titleLabel.frame = frame;
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.size.width = self.currentImage.size.width;
    imageFrame.size.height = self.currentImage.size.height;
    imageFrame.origin.x = (self.frame.size.width - imageFrame.size.width) / 2;
    imageFrame.origin.y = frame.origin.y - imageFrame.size.height;
    self.imageView.frame = imageFrame;
    

}

@end
