//
//  LMMessageViewController.m
//  LMTabBarStyle
//
//  Created by 刘明 on 17/3/15.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "LMMessageViewController.h"
#import "UITabBar+badge.h"

@interface LMMessageViewController ()

@end

@implementation LMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarController.tabBar lm_showBadgeOnItemIndex:3];
    
    self.view.backgroundColor = [UIColor grayColor];
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
