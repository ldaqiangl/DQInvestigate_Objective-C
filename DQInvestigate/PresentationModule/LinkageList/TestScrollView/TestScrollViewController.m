//
//  TestScrollViewController.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/11/19.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "TestScrollViewController.h"
#import "DQButton.h"

@interface TestScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation TestScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor brownColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 64, kScreenWidth-20, 400)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 1000)];
    [scrollView addSubview:contentView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = contentView.bounds;
    [contentView.layer addSublayer:gradientLayer];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor orangeColor].CGColor];
    gradientLayer.locations = @[@(0.5),@(1.0)];
    
    scrollView.contentSize = contentView.bounds.size;
    
    DQButton *btn = [DQButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    btn.frame = CGRectMake(20, 100, 100, 40);
    [btn setTitle:@"点击么" forState:UIControlStateNormal];
    [btn setTitle:@"点击了" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickedBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(outClicked) forControlEvents:UIControlEventTouchDragOutside];
    [btn addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchCancel];
    
    
    [scrollView addSubview:btn];
}

- (void)clickedBtn {
    
    NSLog(@"点击了btn");
}

- (void)outClicked {
    
    NSLog(@"点击移出按钮");
}

- (void)cancelClicked {
    
    NSLog(@"点击取消");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
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
