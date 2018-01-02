//
//  PatientDiagnoseOrder.h
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/25.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 主诉病、影响因素病、
 处理方式、影响因素处理方式、
 药、影响因素药、
 达标值（多种）
 身体状况（多种）
 */
@interface PatientDiagnoseOrder : NSObject

/**
 诊断出的主诉疾病
 */
@property (nonatomic, strong) NSArray *actionInChief;


@end
