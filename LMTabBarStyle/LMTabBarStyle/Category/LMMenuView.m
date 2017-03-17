//
//  LMMenuView.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/17.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMMenuView.h"
#import "LMMenuItem.h"
#import "UIView+LMAdjustFrame.h"

#define LMWindow [UIApplication sharedApplication].keyWindow
#define kLMMenuCenterBtnCenterX ([UIApplication sharedApplication].keyWindow.bounds.size.width / 2)
#define kLMMenuCenterBtnCenterY ([UIApplication sharedApplication].keyWindow.bounds.size.height - 49/2)

CGFloat const kLMMenuItemFarRadius = 100.0f;
CGFloat const kLMMenuItemNearRadius = 140.0f;
CGFloat const kLMMenuItemEndRadius = 120.0f;
CGFloat const kLMMenuItemWholeAngle = M_PI * 0.6;
CGFloat const kLMMenuItemStartAngle = M_PI * 1.2;
CGFloat const kLMMenuItemExpandRotation = M_PI;
CGFloat const kLMMenuItemCloseRotation = M_2_PI;
//CGFloat const kLMMenuCenterBtnCenterX = LMHalfWidth;
//CGFloat const kLMMenuCenterBtnCenterY = 400.0f;
CGFloat const kLMMenuCenterBtnWidth = 50.0f;
CGFloat const kLMMenuAnimationDuration = 0.5f;

static CGPoint RotateCGPointAroundCenter(CGPoint point, CGPoint center, float angle)
{
    CGAffineTransform translation = CGAffineTransformMakeTranslation(center.x, center.y);
    CGAffineTransform rotation = CGAffineTransformMakeRotation(angle);
    CGAffineTransform transformGroup = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translation), rotation), translation);
    return CGPointApplyAffineTransform(point, transformGroup);
}

@interface LMMenuView ()<LMMenuItemDelegate>

@property (nonatomic, strong) LMMenuItem *centerBtn;
@property (nonatomic, strong) NSMutableArray *menuItems;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign, getter=isExpanded) BOOL expanded;
@property (nonatomic, assign, getter=isAnimation) BOOL animation;
@end
@implementation LMMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.startPoint = CGPointMake(kLMMenuCenterBtnCenterX, kLMMenuCenterBtnCenterY);
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [self addSubview:self.centerBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.centerBtn.width = kLMMenuCenterBtnWidth;
    self.centerBtn.height = kLMMenuCenterBtnWidth;
    self.centerBtn.center = self.startPoint;
}


#pragma mark - delegate
#pragma mark - LMMenuItemDelegate
- (void)lm_popupMenuItemTouchesBegan:(LMMenuItem *)item
{
    if (self.isAnimation) return;
    
    if (item == self.centerBtn) {
        
        self.expanded = !self.isExpanded;
        return;
    }
    [self blowupWithItem:item];
    
    for (LMMenuItem *otherItem in self.menuItems) {
        if (otherItem.tag == item.tag) {
            continue;
        }
        
        [self shrinkWithItem:otherItem];
    }
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    self.animation = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.animation = NO;
    
    if ([[anim valueForKey:@"id"] isEqualToString:@"closeAni"]) {
        [self removeFromSuperview];
    }else if ([[anim valueForKey:@"id"] isEqualToString:@"blowupAni"]) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(lm_popupMenuView:selectedIndex:)]) {
            [self.delegate lm_popupMenuView:self selectedIndex:[[anim valueForKey:@"selectedIndex"] integerValue]];
        }
    }
}



#pragma mark - event response

#pragma mark - public methods
+ (instancetype)lm_showWithDelegate:(id)delegate
{
    LMMenuView *menuView = [[LMMenuView alloc] initWithFrame:LMWindow.bounds];
    
    menuView.delegate = delegate;
    
    [LMWindow addSubview:menuView];
    
    [menuView setupMenuItems];
    
    menuView.expanded = YES;
    
    return menuView;
}


#pragma mark - private methods
- (void)setupMenuItems
{
    CGFloat gapAngle = kLMMenuItemWholeAngle / (self.menuItems.count - 1);
    for (LMMenuItem *item in self.menuItems) {
        
        CGFloat angle = kLMMenuItemStartAngle + item.tag * gapAngle;
        
        item.startPoint = CGPointMake(kLMMenuCenterBtnCenterX, kLMMenuCenterBtnCenterY);
        
        CGPoint farPoint = CGPointMake(kLMMenuCenterBtnCenterX + kLMMenuItemFarRadius * cosf(angle), kLMMenuCenterBtnCenterY + kLMMenuItemFarRadius * sinf(angle));
        item.farPoint = RotateCGPointAroundCenter(farPoint, self.startPoint, kLMMenuItemStartAngle);
        item.farPoint = farPoint;
        
        CGPoint nearPoint = CGPointMake(kLMMenuCenterBtnCenterX + kLMMenuItemNearRadius * cosf(angle), kLMMenuCenterBtnCenterY + kLMMenuItemNearRadius * sinf(angle));
        item.nearPoint = RotateCGPointAroundCenter(nearPoint, self.startPoint, kLMMenuItemStartAngle);
        item.nearPoint = nearPoint;
        
        CGPoint endPoint = CGPointMake(kLMMenuCenterBtnCenterX + kLMMenuItemEndRadius * cosf(angle), kLMMenuCenterBtnCenterY + kLMMenuItemEndRadius * sinf(angle));
        item.endPoint = RotateCGPointAroundCenter(endPoint, self.startPoint, kLMMenuItemStartAngle);;
        item.endPoint = endPoint;
        
        item.center = self.startPoint;
        item.width = kLMMenuCenterBtnWidth;
        item.height = kLMMenuCenterBtnWidth;
        
        [self insertSubview:item belowSubview:self.centerBtn];
    }
}


- (void)open
{
    for (LMMenuItem *item in self.menuItems) {
        [self expandWithTag:item.tag];
    }
}

- (void)close
{
    for (LMMenuItem *item in self.menuItems) {
        [self closeWithTag:item.tag];
    }
}

- (void)expandWithTag:(NSInteger)tag
{
    LMMenuItem *item = self.menuItems[tag];
    
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.values = @[@(kLMMenuItemExpandRotation * 3), @0.0f];
    //    rotationAni.duration = kLMMenuAnimationDuration;
    //    rotationAni.keyTimes = @[@(.3), @(.4)];
    
    CAKeyframeAnimation *postionAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    postionAni.duration = kLMMenuAnimationDuration;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, kLMMenuCenterBtnCenterX, kLMMenuCenterBtnCenterY);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.nearPoint.x, item.nearPoint.y);
    CGPathAddLineToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
    postionAni.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotationAni, postionAni];
    group.duration = kLMMenuAnimationDuration;
    group.fillMode = kCAFillModeForwards;
    //    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    group.delegate = self;
    
    [group setValue:@"expandAni" forKey:@"id"];
    
    [item.layer addAnimation:group forKey:@"expandAni"];
    
    item.center = item.endPoint;
    
}

- (void)closeWithTag:(NSInteger)tag
{
    LMMenuItem *item = self.menuItems[tag];
    
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.values = @[@0, @(kLMMenuItemCloseRotation * 3) ,@0];
    //    rotationAni.keyTimes = @[@.0f, @.4f, @.5f];
    
    CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
    positionAni.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotationAni, positionAni];
    group.duration = kLMMenuAnimationDuration;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    
    [group setValue:@"closeAni" forKey:@"id"];
    
    [item.layer addAnimation:group forKey:@"closeAni"];
    
    item.center = item.startPoint;
}

- (void)blowupWithItem:(LMMenuItem *)item
{
    CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAni.values = @[[NSValue valueWithCGPoint:item.center]];
    positionAni.keyTimes = @[@.3f];
    
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAni.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 1)];
    
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.toValue = @[@0.0f];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[positionAni, scaleAni, opacityAni];
    group.duration = kLMMenuAnimationDuration;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    [group setValue:@"blowupAni" forKey:@"id"];
    [group setValue:@(item.tag) forKey:@"selectedIndex"];
    
    [item.layer addAnimation:group forKey:@"blowupAni"];
    
    item.center = item.startPoint;
}

- (void)shrinkWithItem:(LMMenuItem *)item
{
    CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAni.values = @[[NSValue valueWithCGPoint:item.center]];
    positionAni.keyTimes = @[@.3f];
    
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAni.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, 1)];
    
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opactiy"];
    opacityAni.toValue = @[@0.0f];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[positionAni, scaleAni, opacityAni];
    group.duration = kLMMenuAnimationDuration;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    
    [group setValue:@"shrinkAni" forKey:@"id"];
    
    [item.layer addAnimation:group forKey:@"shrinkAni"];
    
    item.center = item.startPoint;
}

#pragma mark - setter and getter

- (LMMenuItem *)centerBtn
{
    

    if (!_centerBtn) {
        _centerBtn = [[LMMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton"] highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted"] contentImage:[UIImage imageNamed:@"icon-pluss"] contentHighlightedImage:[UIImage imageNamed:@"icon-pluss-highlighted"]];
        _centerBtn.delegate = self;
    }
    return _centerBtn;
}

- (NSMutableArray *)menuItems
{
    if (!_menuItems) {
        _menuItems = [NSMutableArray array];
        
        [_menuItems addObject:[self setupMenuItem:@"Card-qq" highlightedImage:@"Card-qq" index:0]];
        [_menuItems addObject:[self setupMenuItem:@"weixin_popover" highlightedImage:@"weixin_popover" index:1]];
        [_menuItems addObject:[self setupMenuItem:@"invite-weibo" highlightedImage:@"invite-weibo" index:2]];
        [_menuItems addObject:[self setupMenuItem:@"qqkongjian_popover" highlightedImage:@"qqkongjian_popover" index:3]];

    }
    return _menuItems;
}

- (LMMenuItem *)setupMenuItem:(NSString *)image highlightedImage:(NSString *)highlightedImage index:(int)index{
    
    LMMenuItem *item = [[LMMenuItem alloc] initWithImage:[UIImage imageNamed:image] highlightedImage:[UIImage imageNamed:highlightedImage] contentImage:nil contentHighlightedImage:nil];
    item.delegate = self;
    item.tag = index;
    
    return item;
}

- (void)setExpanded:(BOOL)expand
{
    if (self.isAnimation) return;
    
    if (expand) {
        [self open];
    }else {
        [self close];
    }
    
    CGFloat angle = expand ? - M_PI_4 : 0.0f;
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.values = @[@(angle)];
    rotationAni.duration = kLMMenuAnimationDuration;
    rotationAni.fillMode = kCAFillModeForwards;
    rotationAni.removedOnCompletion = NO;
    [self.centerBtn.layer addAnimation:rotationAni forKey:@"centerAni"];
    
    _expanded = expand;
}

@end
