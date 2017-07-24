//
//  Scroll3DViewController.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/7/24.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "Scroll3DViewController.h"
#import "DQScroll3DFlowLayout.h"
#import "DQCollectionViewCell.h"


static NSString *DQ3DCellID = @"DQ3DCellID";

@interface Scroll3DViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation Scroll3DViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    DQScroll3DFlowLayout *layout = [[DQScroll3DFlowLayout alloc] init];
    
    UICollectionView *colletionView =
    [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.width_DQExt, 300) collectionViewLayout:layout];
    colletionView.delegate = self;
    colletionView.dataSource = self;
    
    self.collectionView = colletionView;
    [self.view addSubview:colletionView];
    
    [colletionView registerClass:[DQCollectionViewCell class] forCellWithReuseIdentifier:DQ3DCellID];
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:DQ3DCellID forIndexPath:indexPath];
    
    return cell;
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
