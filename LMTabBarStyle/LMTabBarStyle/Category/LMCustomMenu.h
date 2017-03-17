//
//  SecondMenuView.h
//  LoveBB
//
//  Created by 刘明 on 16/10/22.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LMCustomMenuDelegate <NSObject>

- (void)LMCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef void(^Dismiss)(void);
@interface LMCustomMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) id<LMCustomMenuDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrImgName;
@property (nonatomic, copy) Dismiss dismiss;

- (instancetype)initWithDataArr:(NSArray *)dataArr origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight;

- (void)dismissWithCompletion:(void (^)(LMCustomMenu *object))completion;

@end
