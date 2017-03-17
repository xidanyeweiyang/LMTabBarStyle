//
//  LMMenuItem.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/17.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMMenuItem.h"

#import "UIView+LMAdjustFrame.h"

CGFloat const kLMItemContentSizeRatio = .4f;

@interface LMMenuItem ()

@property (nonatomic, strong) UIImageView *contentImageView;
@end
@implementation LMMenuItem

- (instancetype)initWithImage:(UIImage *)image
             highlightedImage:(UIImage *)highlightedImage
                 contentImage:(UIImage *)contentImage
      contentHighlightedImage:(UIImage *)contnetHighlightedImage
{
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        self.image = image;
        self.highlightedImage = highlightedImage;
        
        self.contentImageView.image = contentImage;
        self.contentImageView.highlightedImage = contnetHighlightedImage;
        self.contentImageView.userInteractionEnabled = YES;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:self.contentImageView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentImageView.width = self.width * kLMItemContentSizeRatio;
    self.contentImageView.height = self.height * kLMItemContentSizeRatio;
    self.contentImageView.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(lm_popupMenuItemTouchesBegan:)]) {
        [self.delegate lm_popupMenuItemTouchesBegan:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - delegate

#pragma mark - event response

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - setter and getter
- (UIImageView *)contentImageView
{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
    }
    return _contentImageView;
}

@end
