//
//  DQThirdLibViewController.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/7/17.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQThirdLibViewController.h"
#import "ReactiveProgramingViewController.h"

@interface DQThirdLibViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation DQThirdLibViewController


- (NSMutableArray *)dataSourceArr {
    
    if (!_dataSourceArr) {
        
        _dataSourceArr = [NSMutableArray array];
        NSArray *arr = @[@"ReactNative",@"ReactCocoa",@"YYKit",@"AFNetworking",
                         @"Aspects",@"MagicalRecord",@"JSPatch"];
        for (NSInteger i = 0; i < arr.count; i++) {
            
            [_dataSourceArr addObject:arr[i]];
        }
    }
    return _dataSourceArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    //    UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    UINib *cellNib = [UINib nibWithNibName:@"HardwareTableViewCell" bundle:nil];
    //    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"HardwareTableViewCellID"];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.dataSourceArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        ReactiveProgramingViewController *rpVc = [[ReactiveProgramingViewController alloc] init];
        rpVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rpVc animated:YES];
    }
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
