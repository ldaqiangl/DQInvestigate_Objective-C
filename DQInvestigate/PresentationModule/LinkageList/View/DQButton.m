//
//  DQButton.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/19.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQButton.h"

@implementation DQButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"自定义按钮可以响应此事件-判断位置在否:  位置：%@ ， 事件：%@", NSStringFromCGPoint(point), event);
    
    [self.superview pointInside:point withEvent:event];
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"自定义按钮可以响应此事件-判断响应者能否: 位置：%@ ， 事件：%@",NSStringFromCGPoint(point), event);
    
    [self.superview hitTest:point withEvent:event];
    return [super hitTest:point withEvent:event];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"按钮开始处理触摸事件： 触摸对象-%@， 事件对象：%@", touches, event);
    [super touchesBegan:touches withEvent:event];
    
    [self.superview touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"按钮触摸移动： %@, 事件：%@", touches, event);
    
    [self.superview touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"按钮触摸结束： %@, 事件：%@", touches, event);
    [super touchesEnded:touches withEvent:event];
}




- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    
    NSLog(@"开始跟踪touch： beginTrackingWithTouch : %@ event:%@", touch, event);
    
    [super beginTrackingWithTouch:touch withEvent:event];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    
    NSLog(@"继续跟踪touch ：continueTrackingWithTouch : %@ event:%@", touch, event);
    
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    
    NSLog(@"结束跟踪touch：endTrackingWithTouch : %@ event:%@", touch, event);
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    
    NSLog(@"取消跟踪touch：cancelTrackingWith event:%@", event);
    
    [super cancelTrackingWithEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
