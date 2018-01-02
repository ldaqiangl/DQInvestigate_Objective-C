//
//  Person.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/21.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (Person *)personWithDict:(NSDictionary *)pDict {
    Person *p = [[Person alloc] init];
    p.age = [NSString stringWithFormat:@"%@",pDict[@"age"]];
    p.name = [NSString stringWithFormat:@"%@",pDict[@"name"]];
    
    return p;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"person: -> name:%@ , age:%@",self.name,self.age];
}
@end
