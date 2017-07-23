//
//  DQScrollView.m
//  test
//
//  Created by 董富强 on 2017/7/22.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQScrollView.h"

#import "_DQViewManager.h"

//=====================  =====================

@interface DQScrollView ()

@property (nonatomic, strong) _DQViewManager *vm;

@end
@implementation DQScrollView

@synthesize delegate = _delegate;


- (void)setDelegate:(id<DQScrollViewDelegate>)delegate {
    
    _delegate = _vm;
    [super setDelegate:_delegate];
    
    _vm.delegate = delegate;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _vm = [[_DQViewManager alloc] init];
    }
    return self;
}

- (void)reloadScrollView {
    
    [_vm.numberAxisArr removeAllObjects];
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
        [_vm.reusablePoll.reusableArr removeAllObjects];
    }
    
    NSInteger numOfSections = [self.dataSource numberOfHeader];
    
    NSMutableArray *recordIndexPaths = [NSMutableArray array];
    
    for (NSInteger i = 0; i < numOfSections; i++) {
        
        NSInteger sectionRows = [self.dataSource dqScrollView:self numberOfRowsInSection:i];
        
        NSMutableArray *sectionIndexPaths = [NSMutableArray array];
        for (NSInteger j = 0; j < sectionRows; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            [sectionIndexPaths addObject:indexPath];
        }
        [recordIndexPaths addObject:sectionIndexPaths];
    }
    _vm.recordIndexPaths = recordIndexPaths;
    
    CGFloat headerX = 120;
    for (NSInteger i = 0; i < numOfSections; i++) {
        
//        DQNumberAxis numAxis;
//        numAxis.axisP = CGPointMake(headerX, 0);
//        numAxis.section = i;
//        [_vm.numberAxisArr addObject:NSStringFromDQNumberAxis(numAxis)];
        
        DQHeaderView *headerView = [self.dataSource dqScrollView:self andInSection:i];
        [self addSubview:headerView];
        [_vm.reusablePoll.reusableArr addObject:headerView];
        
        CGFloat headerW = [self.dataSource dqScrollView:self widthForHeaderInSection:i];
        headerView.frame = CGRectMake(headerX, 0, headerW, self.bounds.size.height);
        headerView.startActive = CGPointMake(headerX, 0);
        
        headerX += headerW;
        
        NSArray *sectionIndexPaths = [recordIndexPaths objectAtIndex:i];
        for (NSInteger r = 0; r < sectionIndexPaths.count; r++) {
            
            CGFloat rowWidth = [self.dataSource dqScrollView:self widthForRowIndexPath:sectionIndexPaths[r]];
            headerX += rowWidth;
        }
        headerView.endActive = CGPointMake(headerX - headerW, 0);
    }
    
    self.contentSize = CGSizeMake(headerX, self.bounds.size.height);
}

- (DQHeaderView *)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier {
    
    return nil;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

}

@end
















