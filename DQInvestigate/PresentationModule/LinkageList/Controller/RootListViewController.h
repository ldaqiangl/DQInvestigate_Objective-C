//
//  RootListViewController.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/30.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const HeadViewHeight = 160;
static CGFloat const BS_NAV_H = 44;
static CGFloat const BS_STATEBAR_H = 20;
static CGFloat const BS_TABBAR_H = 49;

typedef NS_ENUM(NSInteger, ListStateType) {
    eListStateTopType = 0,
    eListStateNormalType = 1,
    eListStateNormalTopType = 2,
    eListStateNormalDownType = 3,
};


@interface RootListViewController : UIViewController
@property (nonatomic, weak) UIViewController *managerVc;

//@property (nonatomic, assign) BOOL isSelected;

@property (strong, nonatomic) UIScrollView *scrollView;

- (void)listViewDidAppear;
@end
