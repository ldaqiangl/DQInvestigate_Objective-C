//
//  Person.h
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/21.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, assign) NSInteger userType;//0：家长 1：教师 2：园长
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) NSInteger sex;//0:女 1:男


+ (Person *)personWithDict:(NSDictionary *)pDict;

@end
