//
//  DQHeaderView.h
//  test
//
//  Created by 董富强 on 2017/7/22.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQHeaderView : UIView

@property (nonatomic, assign) CGPoint startActive;
@property (nonatomic, assign) CGPoint endActive;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
