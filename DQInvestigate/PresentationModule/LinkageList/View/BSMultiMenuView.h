//
//  BSMultiMenuView.h
//  HXInvestigate
//
//  Created by 董富强 on 16/8/30.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 多菜单选择管理view */
#import "TableListViewController.h"

@interface BSMultiMenuView : UIView

@property (nonatomic, weak) UIViewController *managerVc;
@property (nonatomic, strong) NSMutableArray *titlesArr;

@end
