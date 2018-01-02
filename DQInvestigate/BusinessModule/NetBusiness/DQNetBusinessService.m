//
//  DQNetBusinessService.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/20.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQNetBusinessService.h"

@implementation DQNetBusinessService

- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(DQSignInResponse)completeBlock {
    
//    NSLog(@"开始异步请求");
//    if (username.length > 3 && password.length > 3) {
//        NSLog(@"请求成功");
//        completeBlock(YES);
//    } else {
//        NSLog(@"请求失败");
//        completeBlock(NO);
//    }
//    return;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:5];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (username.length > 3 && password.length > 3) {
                NSLog(@"请求成功");
                completeBlock(YES);
            } else {
                NSLog(@"请求失败");
                completeBlock(NO);
            }
        });

    });

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
    [arr addObject:@"11"];
    [arr addObject:[[NSObject alloc] init]];
    [arr addObject:@(3)];
    NSLog(@"%@",arr);
    
//    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSLog(@"%d - %@",(int)configure.timeoutIntervalForRequest,configure.description);
//
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:queue];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    request.HTTPMethod = @"GET";
//    NSURLSessionTask *task = [session dataTaskWithRequest:request
//                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//    {
//
//        NSLog(@">>> %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    }];
//    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    NSLog(@">>>==== %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

}

- (RACSignal *)asyncTaskA {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            NSLog(@"%@=>A Task pending",[NSThread currentThread]);
            sleep(1);
            NSLog(@"%@=>A Task done",[NSThread currentThread]);
            
//            [subscriber sendNext:@"A Complete"];
            [subscriber sendError:[NSError errorWithDomain:RACSignalErrorDomain code:RACSignalErrorTimedOut userInfo:@{@"A":@"A"}]];
        });
        return nil;
    }];
}
- (RACSignal *)asyncTaskB {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSLog(@"%@=>B Task pending",[NSThread currentThread]);
            sleep(3);
            NSLog(@"%@=>B Task done",[NSThread currentThread]);
            
//            [subscriber sendNext:@"B Complete"];
//            [subscriber sendCompleted];
            [subscriber sendError:[NSError errorWithDomain:RACSignalErrorDomain code:RACSignalErrorTimedOut userInfo:@{@"BE":@"Berror"}]];

        });
        return nil;
    }];
}
- (RACSignal *)asyncTaskC {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSLog(@"%@=>C Task pending",[NSThread currentThread]);
            sleep(5);
            NSLog(@"%@=>C Task done",[NSThread currentThread]);
            
            [subscriber sendNext:@"C Complete"];
        });
        return nil;
    }];
}
- (RACSignal *)asyncTaskD {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSLog(@"%@=>D Task pending",[NSThread currentThread]);
            sleep(7);
            NSLog(@"%@=>D Task done",[NSThread currentThread]);
            
            [subscriber sendNext:@"D Complete"];
        });
        return nil;
    }];
}

@end
