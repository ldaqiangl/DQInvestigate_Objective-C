//
//  GCDViewController.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/12/14.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "GCDViewController.h"

static dispatch_queue_t business_processing_serial_queue() {
    
//    return dispatch_get_global_queue(0, 0);
    static dispatch_queue_t xzl_business_processing_serial_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xzl_business_processing_serial_queue =
        dispatch_queue_create("com.xinzhili.business.processing", DISPATCH_QUEUE_SERIAL);
    });
    
    return xzl_business_processing_serial_queue;
}

@interface GCDViewController ()

@property (nonatomic, strong) NSMutableDictionary *dataSrouceDict;
@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);
    
    for (NSInteger i = 0; i < 1000; i++) {
        
        dispatch_async(dispatch_queue_create("com.xinzhili.business.processing", DISPATCH_QUEUE_SERIAL), ^{
            
            if (i % 2 == 0) {
                sleep(1);
            }
            NSLog(@"%@：%d",[NSThread currentThread], (int)i);
        });
    }
    
    return;
    NSLog(@"主线程执行1");
    dispatch_async(business_processing_serial_queue(), ^{
       
        sleep(3);
        NSLog(@"异步（一）操作第1步");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            sleep(5);
//            dispatch_semaphore_signal(semaphore1);
        });
//        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
        NSLog(@"异步（一）操作第2步");
    });
    
    NSLog(@"主线程执行2");
    
//    dispatch_semaphore_t semaphore2 = dispatch_semaphore_create(0);
    dispatch_async(business_processing_serial_queue(), ^{
        
        NSLog(@"异步(二)操作第1步");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            sleep(10);
//            dispatch_semaphore_signal(semaphore2);
        });
//        dispatch_semaphore_wait(semaphore2, DISPATCH_TIME_FOREVER);
        NSLog(@"异步(二)操作第2步");
    });
    
    NSLog(@"主线程执行3");

    
    
    //[self startupSignalSyncThreads];
//    [self startupMultiThreadsReadAndWriteDictionary];
}

- (void)startupMultiThreadsReadAndWriteDictionary {
    
    self.lock = [[NSLock alloc] init];
    
    self.dataSrouceDict = [NSMutableDictionary dictionaryWithDictionary:@{@"0":@"",@"1":@"",@"2":@"",@"3":@"",@"4":@""}];
    
    dispatch_queue_t queue = dispatch_queue_create("com.ldaqiangl", DISPATCH_QUEUE_CONCURRENT);
    __weak __typeof(self)weakSelf = self;
    for (NSInteger i = 0; i < 40000; i++) {
        
        dispatch_async(queue, ^{
            
            NSString *key = [NSString stringWithFormat:@"%d",(int)i%5];
//            if ([weakSelf.dataSrouceDict[key] length] == 0) {
//                [weakSelf.dataSrouceDict setObject:[NSString stringWithFormat:@"%d",(int)i] forKey:key];
//            }
            
            [weakSelf.lock lock];
            NSNumber *number = weakSelf.dataSrouceDict[@"0"];
            [weakSelf.dataSrouceDict setObject:[NSNumber numberWithInteger:number.integerValue+1] forKey:@"0"];
            [weakSelf.lock unlock];
            
            NSLog(@"%@:执行子线程：%@",key,[NSThread currentThread]);
        });
    }
    
    sleep(20);
    NSLog(@"===>>%@",self.dataSrouceDict);
}

- (void)startupSignalSyncThreads {
    
    dispatch_async(dispatch_queue_create("com.ldaqiangl", DISPATCH_QUEUE_SERIAL), ^{
        

    });
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = DISPATCH_TIME_FOREVER;//dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_queue_t seriaQ = dispatch_queue_create("com.xzlcorp", DISPATCH_QUEUE_SERIAL);
    for (NSInteger i = 0; i < 10000; i++) {
        
        //dispatch_semaphore_wait(signal, overTime);
        dispatch_async(seriaQ, ^{
            
            dispatch_semaphore_wait(signal, overTime);
            NSLog(@"需要线程同步的操作%d 开始",(int)i);
            //sleep(3);
            NSLog(@"|");
            NSLog(@"|");
            NSLog(@"需要线程同步的操作%d 结束 \n",(int)i);
            dispatch_semaphore_signal(signal);
        });
    }
    
    NSLog(@"====");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
