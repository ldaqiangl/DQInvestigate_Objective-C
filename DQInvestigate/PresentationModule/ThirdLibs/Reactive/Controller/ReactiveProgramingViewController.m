//
//  ReactiveProgramingViewController.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/7/17.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "ReactiveProgramingViewController.h"
#import "DQNetBusinessService.h"
#import "ReactiveTwiterViewController.h"

@import ReactiveObjC;

@interface ReactiveProgramingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameInputField;
@property (weak, nonatomic) IBOutlet UITextField *pwdInputField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, strong) DQNetBusinessService *netBus;

@end

@implementation ReactiveProgramingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithTitle_DQExt:@"<" target:self action:@selector(back)];
    self.netBus = [[DQNetBusinessService alloc] init];
    
//    //1.处理输入框
//    RACSignal *nameValidSignal =
//    [self.nameInputField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//
//        return @([self isValidName:value]);
//    }];
//    RACSignal *pwdValidSignal =
//    [self.pwdInputField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//
//        return @([self isValidPwd:value]);
//    }];
//
//
//    RAC(self.nameInputField, backgroundColor) =
//    [nameValidSignal map:^id _Nullable(id  _Nullable value) {
//
//        return ![value boolValue] ? [UIColor redColor] : [UIColor greenColor];
//    }];
//    RAC(self.pwdInputField, backgroundColor) =
//    [pwdValidSignal map:^id _Nullable(NSNumber *value) {
//
//        return ![value boolValue] ? [UIColor redColor] : [UIColor greenColor];
//    }];
//
//
//    //2.处理按钮
//    RACSignal *signupSignal =
//    [RACSignal combineLatest:@[nameValidSignal, pwdValidSignal] reduce:^id _Nullable(NSNumber *usernameValid, NSNumber *passwordValid) {
//
//        return @([usernameValid boolValue] && [passwordValid boolValue]);
//    }];
//
//    RAC(self.loginBtn, enabled) = signupSignal;
//
//    @weakify(self);
//    [[[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
//       doNext:^(__kindof UIControl * _Nullable x) {
//
//           NSLog(@">>>>>>%@",x);
//       }] flattenMap:^id _Nullable(id value) {
//
//           return [self signupSignal];
//       }] subscribeNext:^(NSNumber *signedIn) {
//
//           NSLog(@"===---===");
//           BOOL success = [signedIn boolValue];
//           if (success) {
//
//               //              @strongify(self);
//               //              [self.navigationController pushViewController:[[ReactiveTwiterViewController alloc] init] animated:YES];
//               //              [[self signupSignal] subscribeNext:^(NSNumber *x) {
//               //                  @strongify(self);
//               //                  if ([x boolValue] == YES) {
//               //
//               //                      [self.navigationController pushViewController:[[ReactiveTwiterViewController alloc] init] animated:YES];
//               //                  } else {
//               //
//               //                  }
//               //              }];
//           }
//       } error:^(NSError * _Nullable error) {
//
//           NSLog(@"====>> %@",error.description);
//       } completed:^{
//
//           NSLog(@"----");
//       }];
//
//
//    [[self.nameInputField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//
//        return @(value.length);
//    }] subscribeNext:^(id  _Nullable x) {
//
//    }];;
}



- (IBAction)loginClicked:(id)sender {
    
}

- (IBAction)registerClicked:(id)sender {
    
    RACSignal *sigA = [self.netBus asyncTaskA];
    RACSignal *sigB = [self.netBus asyncTaskB];
    
    [[sigB takeUntil:sigA] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"----%@",x);
    } error:^(NSError * _Nullable error) {
        
        NSLog(@"----%@",error);
    } completed:^{
        
        NSLog(@"--+++--");
    }];
    
    return;
    RACSignal *sig = [[RACSignal combineLatest:@[sigA,sigB] reduce:^id _Nullable(id a, id b) {
        
        return [NSString stringWithFormat:@"%@+%@",a,b];
    }] timeout:10 onScheduler:[RACScheduler scheduler]];
    
    [[sig deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@=>%@",[NSThread currentThread],x);
    } error:^(NSError * _Nullable error) {
        
        NSLog(@"%@=发生错误:%@",[NSThread currentThread],error.description);
    } completed:^{
        
        NSLog(@"%@=>完成调用",[NSThread currentThread]);
    }];
    
    //[self.navigationController pushViewController:[[ReactiveTwiterViewController alloc] init] animated:YES];
}

- (RACSignal *)signupSignal {
    
    [self.netBus
     signInWithUsername:self.nameInputField.text
     password:self.pwdInputField.text
     complete:^(BOOL success) {
         
     }];
    return nil;
//    return [RACReplaySubject createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        [self.netBus
//         signInWithUsername:self.nameInputField.text
//         password:self.pwdInputField.text
//         complete:^(BOOL success) {
//
//             [subscriber sendNext:@(success)];
//             [subscriber sendCompleted];
//         }];
//
//        return nil;
//    }];
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [self.netBus
         signInWithUsername:self.nameInputField.text
         password:self.pwdInputField.text
         complete:^(BOOL success) {
             
             [subscriber sendNext:@(success)];
             //[subscriber sendCompleted];
         }];
        
        return [RACDisposable disposableWithBlock:^{
            
            NSLog(@"超时时间到");
        }];
    }];
}


- (BOOL)isValidName:(NSString *)text {
    
    return text.length > 3;
}

- (BOOL)isValidPwd:(NSString *)text {
    
    return text.length > 3;
}



- (void)back {

    
    [self.navigationController popViewControllerAnimated:YES];
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
