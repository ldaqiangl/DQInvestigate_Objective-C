//
//  RootListViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/8/30.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "RootListViewController.h"


@interface RootListViewController ()
{
    CGFloat _preIsCanScrollOffY;
}
@property (nonatomic, assign) BOOL isCanScroll;

@end


@implementation RootListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isCanScroll = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)listViewDidAppear
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;

    if (!_isCanScroll) {
        [scrollView setContentOffset:CGPointMake(0, _preIsCanScrollOffY)];
    } else {
        _preIsCanScrollOffY = MAX(offsetY, 0);
    }

    _scrollView = scrollView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"listState"]) {
        ListStateType type = [[change objectForKey:@"new"] integerValue];
        if (type == eListStateNormalTopType) {
            _isCanScroll = NO;
        } else {
            _isCanScroll = YES;
        }
    }
}


- (void)didReceiveMemoryWarning
{
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
