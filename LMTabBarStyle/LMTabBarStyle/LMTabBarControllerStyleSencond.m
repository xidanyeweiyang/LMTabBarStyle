//
//  LMTabBarControllerStyleSencond.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/15.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMTabBarControllerStyleSencond.h"
#import "LMHomeViewController.h"
#import "LMDiscoverViewController.h"
#import "LMMessageViewController.h"
#import "LMProfileViewController.h"

#import "LMMenuView.h"
#import "LMMenuItem.h"
#import "UIView+LMAdjustFrame.h"

@interface LMTabBarControllerStyleSencond ()<LMMenuViewDelegate>

@property (nonatomic, strong) UIButton *composeButton;

@end

@implementation LMTabBarControllerStyleSencond

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1]];
    
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    [self addChildViewController];
    
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    CGRect frame = self.tabBar.bounds;
    
    CGFloat width = frame.size.width / self.viewControllers.count - 1;
    self.composeButton.frame = CGRectInset(frame, 2*width, 0);
    
}

- (void)addChildViewController{
    
    [self addOneChildVC:@"LMHomeViewController" title:@"首页" imageName:@"home" selectedImageName:@"audit_press"];
    [self addOneChildVC:@"LMDiscoverViewController" title:@"发现" imageName:@"Found" selectedImageName:@"Found_press"];
    [self addOneChildVC:@"" title:@"" imageName:@"" selectedImageName:@""];
    [self addOneChildVC:@"LMMessageViewController" title:@"消息" imageName:@"newstab" selectedImageName:@"newstab_press"];
    [self addOneChildVC:@"LMProfileViewController" title:@"我的" imageName:@"audit" selectedImageName:@"audit_press"];
    
}

- (void)addOneChildVC:(NSString *)childViewControllerName title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    if ([childViewControllerName isEqualToString:@""]) {
        
        [self addChildViewController:[[UIViewController alloc] init]];
        return;
    }
    
    UIViewController *childVc = (UIViewController *)[[NSClassFromString(childViewControllerName) alloc] init];
    
    // 设置标题
    childVc.tabBarItem.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSLog(@"%s",__func__);
    
    NSInteger index = [tabBar.items indexOfObject:item];
    
    [self addAnimationToIndex:index];
    
}


- (void)addAnimationToIndex:(NSInteger)index{
    
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CAKeyframeAnimation *bounceAnimation = [[CAKeyframeAnimation alloc] init];
    
    bounceAnimation.keyPath = @"transform.scale";
    
    bounceAnimation.values = @[@1.0 ,@1.4, @0.9, @1.15, @0.95, @1.02, @1.0];
    
    bounceAnimation.duration = 0.6;
    
    bounceAnimation.calculationMode = kCAAnimationCubic;
    
    [[tabbarbuttonArray[index] layer] addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    //    UIImage *renderImage = [iconView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //
    //    iconView.image = renderImage;
    //
    //        iconView.tintColor = self.iconSelctexColor;
    
}

#pragma mark - LMMenuViewDelegate
- (void)popupMenuView:(LMMenuView *)view selectedIndex:(NSInteger)index
{
    
    [self tabBar:self.tabBar didSelectItem:self.tabBar.items[index]];


}


#pragma mark - 点击事件

- (void)clickComposeButton:(UIButton *)sender{

    [LMMenuView lm_showWithDelegate:self];

    NSLog(@"点击了composeButton");
}

#pragma mark - 懒加载

- (UIButton *)composeButton {
    if (_composeButton == nil) {
        _composeButton = [[UIButton alloc] init];
        
        // 设置按钮图像
        [_composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        // 添加到 tabBar
        [self.tabBar addSubview:_composeButton];
        
        // 添加按钮监听方法
        [_composeButton addTarget:self action:@selector(clickComposeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _composeButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
