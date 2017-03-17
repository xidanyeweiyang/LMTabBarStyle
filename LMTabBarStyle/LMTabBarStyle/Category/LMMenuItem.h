//
//  LMMenuItem.h
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/17.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMMenuItem;

@protocol LMMenuItemDelegate <NSObject>

@optional
- (void)lm_popupMenuItemTouchesBegan:(LMMenuItem *)item;

@end


@interface LMMenuItem : UIImageView

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint farPoint;
@property (nonatomic, assign) CGPoint nearPoint;
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, weak) id<LMMenuItemDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image
             highlightedImage:(UIImage *)highlightedImage
                 contentImage:(UIImage *)contentImage
      contentHighlightedImage:(UIImage *)contnetHighlightedImage;

@end
