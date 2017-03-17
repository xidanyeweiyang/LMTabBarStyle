//
//  LMTabBarControllerStyleThird.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/15.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMTabBarControllerStyleThird.h"
#import "LMHomeViewController.h"
#import "LMDiscoverViewController.h"
#import "LMMessageViewController.h"
#import "LMProfileViewController.h"

@interface LMTabBarControllerStyleThird ()

@end

@implementation LMTabBarControllerStyleThird

- (instancetype)init{
    
    if (self == [super init]) {
        
        [self setupChildViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setupTabBarController{
    
    YALFoldingTabBarController *tabBarController = [[YALFoldingTabBarController alloc] init];
    
    tabBarController.viewControllers = [self setupChildViewControllers];
    
    //prepare leftBarItems
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"nearby_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"profile_icon"]
                                                      leftItemImage:[UIImage imageNamed:@"edit_icon"]
                                                     rightItemImage:nil];
    
    tabBarController.leftBarItems = @[item1, item2];
    
    //prepare rightBarItems
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"chats_icon"]
                                                      leftItemImage:[UIImage imageNamed:@"search_icon"]
                                                     rightItemImage:[UIImage imageNamed:@"new_chat_icon"]];
    
    
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"settings_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    tabBarController.rightBarItems = @[item3, item4];
    
    
    tabBarController.centerButtonImage = [UIImage imageNamed:@"plus_icon"];
    
    tabBarController.selectedIndex = 1;
    
    //customize tabBarView
    tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    tabBarController.tabBarView.backgroundColor = [UIColor colorWithRed:94.f/255.f green:91.f/255.f blue:149.f/255.f alpha:1.f];
    tabBarController.tabBarView.tabBarColor = [UIColor colorWithRed:72.f/255.f green:211.f/255.f blue:178.f/255.f alpha:1.f];
    tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
    tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
//    
//    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    
//    self.window.backgroundColor = [UIColor whiteColor];
//    
//    self.window.rootViewController = tabBarController;
//    
//    [self.window makeKeyAndVisible];
    
}

- (NSArray *)setupChildViewControllers{
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[LMHomeViewController new]];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[LMDiscoverViewController new]];
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[LMMessageViewController new]];
    
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:[LMProfileViewController new]];
    
    return [NSArray arrayWithObjects:nav1,nav2,nav3,nav4, nil];
    
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
