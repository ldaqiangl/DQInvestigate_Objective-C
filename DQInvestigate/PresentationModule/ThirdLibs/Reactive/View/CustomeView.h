//
//  CustomeView *cView; CustomeView.h
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/22.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@import ReactiveObjC;
#import <AFNetworking/AFNetworking.h>
#import "Aspects.h"

typedef NS_OPTIONS(NSInteger, CustomeViewEventType) {
    eCustomeViewBlueBtnClickedEventType = 0,
};

@interface CustomeView : UIView

@property (weak, nonatomic) IBOutlet UIButton *customBtn;

- (IBAction)customeBtnClick:(id)sender;

- (RACSignal *)customeViewEventSigalWith:(CustomeViewEventType)eventType;

@end
