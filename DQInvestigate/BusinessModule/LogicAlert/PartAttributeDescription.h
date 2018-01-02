//
//  PartAttributeDescription.h
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/24.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PartAttributeDescription;

/**
 每个医学逻辑（AlertLogicEntityDescription）组成因素的属性描述类
 这些因素可能包含:
 主诉病、影响因素病、
 处理方式、影响因素处理方式、
 药、影响因素药、
 达标值（多种）
 身体状况（多种）
 */
@protocol PartAttributeDescriptionInterface

/**
 此步实例名称
 */
@property (nonatomic, copy) NSString *name;
/**
 此步实例 描述的是属于什么类型
 */
@property (nonatomic, copy) NSString *attributeType;
/**
 对此步实例 进行的操作类型（不做匹配、数据匹配、计算匹配(sql)等）
 */
@property (nonatomic, copy) NSString *operationAttributeType;
/**
 计算方法
 */
@property (nonatomic, copy) BOOL(^conditionCalculate)();

/**
 开始分析数据action
 */
- (PartAttributeDescription *(^)(id))startAnalyze;

@end

@interface PartAttributeDescription : NSObject <PartAttributeDescriptionInterface>

@end










