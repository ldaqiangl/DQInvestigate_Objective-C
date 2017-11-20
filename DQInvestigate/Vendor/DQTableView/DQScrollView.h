//
//  DQScrollView.h
//  test
//
//  Created by 董富强 on 2017/7/22.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DQHeaderView.h"

@class DQScrollView;
@protocol DQScrollViewDelegate <NSObject,UIScrollViewDelegate>

- (void)select;

@end
@protocol DQScrollViewDataSource <NSObject>

- (NSInteger)numberOfHeader;

- (DQHeaderView *)dqScrollView:(DQScrollView *)scrollView
                  andInSection:(NSInteger)section;

- (CGFloat)dqScrollView:(DQScrollView *)scrollView
    widthForHeaderInSection:(NSInteger)section;

- (NSInteger)dqScrollView:(DQScrollView *)scrollView
    numberOfRowsInSection:(NSInteger)section;

- (CGFloat)dqScrollView:(DQScrollView *)scrollView
  widthForRowIndexPath:(NSIndexPath *)indexPath;

@end

@interface DQScrollView : UIScrollView

@property (nonatomic, assign) id<DQScrollViewDelegate> delegate;
@property (nonatomic, assign) id<DQScrollViewDataSource> dataSource;

- (void)reloadScrollView;

- (DQHeaderView *)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier;

@end








