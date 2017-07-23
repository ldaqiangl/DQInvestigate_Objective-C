//
//  CustomeTableViewController.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/7/23.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "CustomeTableViewController.h"
#import "DQScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CustomeTableViewController ()
<DQScrollViewDelegate,DQScrollViewDataSource>

@property (nonatomic, weak) DQScrollView *scrollView;

@end

@implementation CustomeTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Custome TableView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    DQScrollView *scrollView =
    [[DQScrollView alloc]
     initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.height_DQExt-64)];
    
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    scrollView.dataSource = self;
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];
    
    [_scrollView reloadScrollView];
}


- (void)select {
    
    NSLog(@"===---===");
}


// header
- (NSInteger)numberOfHeader {
    
    return 5;
}

- (DQHeaderView *)dqScrollView:(DQScrollView *)scrollView andInSection:(NSInteger)section {
    
    DQHeaderView *headerView = [scrollView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        
        headerView = [[DQHeaderView alloc] initWithReuseIdentifier:@"header"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
        label.text = @"<<<<";
        label.textColor = [UIColor whiteColor];
        [headerView addSubview:label];
        headerView.backgroundColor = section%2 ==0 ? [UIColor redColor] : [UIColor blueColor];
    }
    return headerView;
}

- (CGFloat)dqScrollView:(DQScrollView *)scrollView widthForHeaderInSection:(NSInteger)section {
    
    if (section % 2 == 0) {
        return 43.0;
    }
    return 60.0;
}

//row
- (NSInteger)dqScrollView:(DQScrollView *)scrollView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)dqScrollView:(DQScrollView *)scrollView widthForRowIndexPath:(NSIndexPath *)indexPath {
    
    return 30.0;
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
