//
//  ViewController.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/15.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "LMTabBarControllerStyleFirst.h"
#import "LMTabBarControllerStyleSencond.h"
#import "LMTabBarControllerStyleThird.h"

#import "LMHomeViewController.h"
#import "LMDiscoverViewController.h"
#import "LMMessageViewController.h"
#import "LMProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didClickLMTarBarStyleFirst:(id)sender {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = [[LMTabBarControllerStyleFirst alloc] init];
    app.window.backgroundColor = [UIColor whiteColor];
    [app.window makeKeyAndVisible];
}

- (IBAction)didClickLMTarBarStyleSencond:(id)sender {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = [LMTabBarControllerStyleSencond new];
    app.window.backgroundColor = [UIColor whiteColor];
    [app.window makeKeyAndVisible];
}

- (IBAction)didClickLMTarBarStyleThird:(id)sender {
    
    [self setupTabBarController];
}

- (void)setupTabBarController{
    
    YALFoldingTabBarController *tabBarController = [[YALFoldingTabBarController alloc] initWithChildViewcontrollers:[self setupChildViewControllers]];
    
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
    
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = tabBarController;
    app.window.backgroundColor = [UIColor whiteColor];
    [app.window makeKeyAndVisible];

    
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


@end
