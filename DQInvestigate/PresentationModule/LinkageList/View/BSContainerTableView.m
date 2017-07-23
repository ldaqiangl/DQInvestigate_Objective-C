//
//  BSContainerTableView.m
//  HXInvestigate
//
//  Created by 董富强 on 16/8/31.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "BSContainerTableView.h"

@implementation BSContainerTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
