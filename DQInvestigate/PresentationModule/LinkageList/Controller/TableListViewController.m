//
//  TableListViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/8/30.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "TableListViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "NetDataModel.h"

#import "CustomeTableViewController.h"
#import "CollectionViewController.h"

@interface TableListViewController ()
<UITableViewDelegate,UITableViewDataSource>
{
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation TableListViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)listViewDidAppear {
    
    [super listViewDidAppear];
    
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
        [self.view addSubview:tableView];
        //
        //        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        //            [_tableView.mj_header endRefreshing];
        //        }];
        
        
        // YiRefreshHeader  头部刷新按钮的使用
        refreshHeader=[[YiRefreshHeader alloc] init];
        refreshHeader.scrollView=tableView;
        [refreshHeader header];
        typeof(refreshHeader) __weak weakRefreshHeader = refreshHeader;
        refreshHeader.beginRefreshingBlock=^(){
            // 后台执行：
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(2);
                dispatch_async(dispatch_get_main_queue(), ^{
                    typeof(weakRefreshHeader) __strong strongRefreshHeader = weakRefreshHeader;
                    // 主线程刷新视图
                    [tableView reloadData];
                    [strongRefreshHeader endRefreshing];
                });
            });
        };
        
        // YiRefreshFooter  底部刷新按钮的使用
        refreshFooter=[[YiRefreshFooter alloc] init];
        refreshFooter.scrollView=tableView;
        [refreshFooter footer];
        typeof(refreshFooter) __weak weakRefreshFooter = refreshFooter;
        
        refreshFooter.beginRefreshingBlock=^(){
            // 后台执行：
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(2);
                dispatch_async(dispatch_get_main_queue(), ^{
                    typeof(weakRefreshFooter) __strong strongRefreshFooter = weakRefreshFooter;
                    // 主线程刷新视图
                    [tableView reloadData];
                    [strongRefreshFooter endRefreshing];
                });
            });
        };
    }
    
    // 是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];
    
    [self loadData];
    
}

- (void)loadData {
    
    for (int i = 0; i < 20; i++) {
//        ClassNewsModel 
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NetDataModel *dataModle = [self.dataSourceArr objectAtIndex:indexPath.row];
    cell.textLabel.text = dataModle.titleName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        CustomeTableViewController *customeTableVc = [[CustomeTableViewController alloc] init];
        customeTableVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:customeTableVc animated:YES];
    } else if (indexPath.row == 1) {
        
        CollectionViewController *collectionVc = [[CollectionViewController alloc] init];
        collectionVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collectionVc animated:YES];
    }
}

- (NSMutableArray *)dataSourceArr {
    
    if (!_dataSourceArr) {
        
        _dataSourceArr = [NSMutableArray array];
        
        NSArray *arr = @[@"TableView Test",@"CollectionView Test"];
        
        for (NSInteger i = 0; i < 10; i++) {
            
            NetDataModel *dataModle = [[NetDataModel alloc] init];
            
            if (i < arr.count) {
                
                dataModle.titleName = arr[i];
            } else {
                
                dataModle.titleName = [NSString stringWithFormat:@"this is %d",(int)i];
            }
            [_dataSourceArr addObject:dataModle];
        }
    }
    return _dataSourceArr;
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
