//
//  LMTabBarControllerStyleFirst.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/15.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMTabBarControllerStyleFirst.h"
#import "LMHomeViewController.h"
#import "LMDiscoverViewController.h"
#import "LMMessageViewController.h"
#import "LMProfileViewController.h"
#import "LMTarBarBigButton.h"

@interface LMTabBarControllerStyleFirst ()

@end

@implementation LMTabBarControllerStyleFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1]];
    
//    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f]];
    
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

    [self setupTabBar];
    
    [self addChildViewController];
    
}

- (void)setupTabBar{
    
    LMTarBarBigButton *lmTabBar = [[LMTarBarBigButton alloc] init];
    
    [self setValue:lmTabBar forKey:@"tabBar"];
}

- (void)addChildViewController{
    
    [self addOneChildVC:@"LMHomeViewController" title:@"首页" imageName:@"home" selectedImageName:@"audit_press"];
    [self addOneChildVC:@"LMDiscoverViewController" title:@"发现" imageName:@"Found" selectedImageName:@"Found_press"];
    [self addOneChildVC:@"UIViewController" title:@"" imageName:@"" selectedImageName:@""];
    [self addOneChildVC:@"LMMessageViewController" title:@"消息" imageName:@"newstab" selectedImageName:@"newstab_press"];
    [self addOneChildVC:@"LMProfileViewController" title:@"我的" imageName:@"audit" selectedImageName:@"audit_press"];

}

- (void)addOneChildVC:(NSString *)childViewControllerName title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
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
