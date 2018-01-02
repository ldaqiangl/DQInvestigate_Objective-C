//
//  AlertLogicEntityDescription.h
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/24.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartAttributeDescription.h"

/**
 每一条细分逻辑对应的实例描述类
 负责描述一条医学逻辑实例的所有信息
 （通过组合#PartAttributeDescription# 以及自身提供一些描述的关键信息组成）
 */
@interface AlertLogicEntityDescription : NSObject

@property (nonatomic, strong) NSMutableArray *parts;

@end
