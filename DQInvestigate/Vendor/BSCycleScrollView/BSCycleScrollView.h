//
//  BSCycleScrollView.h
//  HXInvestigate
//
//  Created by 董富强 on 16/9/2.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCycleScrollView;

@protocol BSCycleScrollViewDelegate <NSObject>

@optional
/** 点击图片回调 */
- (void)cycleScrollView:(BSCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index;

@required
/** 图片滚动回调 */
- (void)cycleScrollView:(BSCycleScrollView *)cycleScrollView
       didScrollToIndex:(NSInteger)index;

@end


@interface BSCycleScrollView : UIView

/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;
/** 每张图片对应要显示的文字数组 */
@property (nonatomic, strong) NSArray *titlesGroup;
/** 本地图片数组 */
@property (nonatomic, strong) NSArray *localizationImageNamesGroup;


@property (nonatomic, weak) id<BSCycleScrollViewDelegate> delegate;
@property (nonatomic, strong) UIImage *placeholderImage;


/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/** 是否无限循环,默认Yes */
@property (nonatomic, assign) BOOL infiniteLoop;


+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<BSCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

@end
