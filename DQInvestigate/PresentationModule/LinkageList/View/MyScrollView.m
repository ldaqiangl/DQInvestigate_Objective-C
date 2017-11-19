//
//  MyScrollView.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/19.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"MyScrollView可以响应此事件-判断位置在否:  位置：%@ ， 事件：%@", NSStringFromCGPoint(point), event);
    
    [self.superview pointInside:point withEvent:event];
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"MyScrollView可以响应此事件-判断响应者能否: 位置：%@ ， 事件：%@",NSStringFromCGPoint(point), event);
    
    [self.superview hitTest:point withEvent:event];
    return [super hitTest:point withEvent:event];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"MyScrollView开始处理触摸事件： 触摸对象-%@， 事件对象：%@", touches, event);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"MyScrollView触摸移动： %@, 事件：%@", touches, event);
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"MyScrollView触摸结束： %@, 事件：%@", touches, event);
    [super touchesEnded:touches withEvent:event];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
