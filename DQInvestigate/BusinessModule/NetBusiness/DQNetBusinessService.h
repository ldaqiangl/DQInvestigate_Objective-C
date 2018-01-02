//
//  DQNetBusinessService.h
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/20.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ReactiveObjC;

typedef void (^DQSignInResponse)(BOOL);

@interface DQNetBusinessService : NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate>


- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(DQSignInResponse)completeBlock;


- (RACSignal *)asyncTaskA;
- (RACSignal *)asyncTaskB;
- (RACSignal *)asyncTaskC;
- (RACSignal *)asyncTaskD;

@end


