//
//  LMMenuView.h
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/17.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LMMenuViewDelegate;

@interface LMMenuView : UIView

@property (nonatomic, weak) id<LMMenuViewDelegate> delegate;

+ (instancetype)lm_showWithDelegate:(id)delegate;

@end

@protocol LMMenuViewDelegate <NSObject>

@optional
- (void)lm_popupMenuView:(LMMenuView *)view selectedIndex:(NSInteger)index;

@end
