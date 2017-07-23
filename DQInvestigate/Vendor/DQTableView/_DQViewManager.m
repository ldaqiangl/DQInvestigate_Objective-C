//
//  _DQViewManager.m
//  test
//
//  Created by 董富强 on 2017/7/22.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "_DQViewManager.h"

NSString *NSStringFromDQNumberAxis(DQNumberAxis numAxis) {
    
    NSString *point = NSStringFromCGPoint(numAxis.axisP);
    NSString *indexPath =
    [NSString stringWithFormat:@"%d|%d",(int)numAxis.section,(int)numAxis.row];
    return [NSString stringWithFormat:@"%@|%@",point,indexPath];
}
DQNumberAxis DQNumberAxisFromString(NSString *string) {
    
    NSArray *arr = [string componentsSeparatedByString:@"|"];
    
    DQNumberAxis numAxis;
    numAxis.axisP = CGPointFromString(arr[0]);
    numAxis.section = [arr[1] integerValue];
    numAxis.row = [arr[2] integerValue];
    return numAxis;
}


@interface _DQViewManager ()
{
    CGPoint _currentPoint;//判断滑动方向
    CGRect _originalRect;// 记录停留视图原始位置
    BOOL _isScroll;// 停留视图是否要滑动
}

@end

@implementation _DQViewManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        _numberAxisArr = [NSMutableArray array];
        _reusablePoll = [[_DequeueReusablePoll alloc] init];
    }
    return self;
}

- (void)select {
    
    if ([_delegate respondsToSelector:@selector(select)]) {
        
        [_delegate select];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //DQScrollView *dqScrollView = (DQScrollView *)scrollView;
    
    CGFloat off_d = scrollView.contentOffset.x;
    //镜头范围 出镜头的可以用于复用
    //CGFloat maxVisible = off_d + scrollView.bounds.size.width;
    
    for (NSInteger i = 0; i < _reusablePoll.reusableArr.count; i++) {
        
        DQHeaderView *headerView = _reusablePoll.reusableArr[i];
        
        if (off_d < headerView.startActive.x) {
            
            headerView.frame =
            CGRectMake(headerView.startActive.x, headerView.frame.origin.y,
                       headerView.frame.size.width, headerView.frame.size.height);
        } else if (off_d >= headerView.endActive.x) {
            
            headerView.frame =
            CGRectMake(headerView.endActive.x, headerView.frame.origin.y,
                       headerView.frame.size.width, headerView.frame.size.height);
        } else {
            
            headerView.frame =
            CGRectMake(off_d, headerView.frame.origin.y,
                       headerView.frame.size.width, headerView.frame.size.height);
        }
    }
}


/*
     if (_currentPoint.x > scrollView.contentOffset.x) {// 向左滑动了
 
         NSLog(@">>>>>>>>>>>");
         if (_isScroll == NO) {
 
             if (_originalRect.origin.x >= scrollView.contentOffset.x) {
 
                 _isScroll = YES;
             }
         }
     } else {
 
         NSLog(@"<<<<<<<<<<<");
         if (_originalRect.origin.x <= scrollView.contentOffset.x) {
 
             _isScroll = NO;
         }
     }
 */




@end




@implementation _DequeueReusablePoll

- (NSMutableArray *)reusableArr {
    
    if (!_reusableArr) {
        
        _reusableArr = [NSMutableArray array];
    }
    return _reusableArr;
}
- (DQHeaderView *)cacheDQHeaderViewWith:(NSInteger)section {
    
    
    return [self.reusableArr objectAtIndex:section];
}
@end










