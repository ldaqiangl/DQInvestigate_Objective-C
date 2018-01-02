//
//  CustomeView *cView; CustomeView.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/22.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "CustomeView.h"

@implementation CustomeView

- (IBAction)customeBtnClick:(id)sender {
    
    
}

- (RACSignal *)customeViewEventSigalWith:(CustomeViewEventType)eventType {
    
    return [self rac_signalForSelector:@selector(customeBtnClick:)];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
