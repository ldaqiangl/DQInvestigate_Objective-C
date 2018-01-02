//
//  PartAttributeDescription.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/24.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "PartAttributeDescription.h"

@implementation PartAttributeDescription
@synthesize name;
@synthesize attributeType;
@synthesize operationAttributeType;
@synthesize conditionCalculate;

/**
 开始分析数据action
 */
- (PartAttributeDescription *(^)(id))startAnalyze {
    
    return ^PartAttributeDescription* (id userInfoModel) {
        
        return self;
    };
}

@end




