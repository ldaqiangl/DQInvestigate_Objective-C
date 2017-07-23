//
//  _DQViewManager.h
//  test
//
//  Created by 董富强 on 2017/7/22.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DQScrollView.h"
@class _DequeueReusablePoll;

typedef struct DQNumberAxis {
    
    CGPoint axisP;
    NSInteger section;
    NSInteger row;
}DQNumberAxis;

UIKIT_EXTERN NSString *NSStringFromDQNumberAxis(DQNumberAxis numAxis);
UIKIT_EXTERN DQNumberAxis DQNumberAxisFromString(NSString *string);

@interface _DQViewManager : NSObject
<DQScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *numberAxisArr;
@property (nonatomic, strong) NSMutableArray *recordIndexPaths;
@property (nonatomic, strong) _DequeueReusablePoll *reusablePoll;

@property (nonatomic, weak) id<DQScrollViewDelegate> delegate;


@end


// 重复使用池
@interface _DequeueReusablePoll : NSObject

@property (nonatomic, strong) NSMutableArray *reusableArr;

- (DQHeaderView *)cacheDQHeaderViewWith:(NSInteger)section;

@end







