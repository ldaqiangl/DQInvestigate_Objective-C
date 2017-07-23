//
//  DQUITestViewController.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/7/17.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQUITestViewController.h"
#import "LinkageListViewController.h"

@interface DQUITestViewController ()

@end

@implementation DQUITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LinkageListViewController *listVc = [[LinkageListViewController alloc] init];
    listVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVc animated:YES];
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
