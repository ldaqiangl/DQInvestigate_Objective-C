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
#import "TestScrollViewController.h"

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
        tableView.backgroundColor = [UIColor orangeColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
        [self.view addSubview:tableView];
        
//        //        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        //            [_tableView.mj_header endRefreshing];
//        //        }];
//
//        // YiRefreshHeader  头部刷新按钮的使用
//        refreshHeader=[[YiRefreshHeader alloc] init];
//        refreshHeader.scrollView=tableView;
//        [refreshHeader header];
//        typeof(refreshHeader) __weak weakRefreshHeader = refreshHeader;
//        refreshHeader.beginRefreshingBlock=^(){
//            // 后台执行：
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                sleep(2);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    typeof(weakRefreshHeader) __strong strongRefreshHeader = weakRefreshHeader;
//                    // 主线程刷新视图
//                    [tableView reloadData];
//                    [strongRefreshHeader endRefreshing];
//                });
//            });
//        };
//
//        // YiRefreshFooter  底部刷新按钮的使用
//        refreshFooter=[[YiRefreshFooter alloc] init];
//        refreshFooter.scrollView=tableView;
//        [refreshFooter footer];
//        typeof(refreshFooter) __weak weakRefreshFooter = refreshFooter;
//
//        refreshFooter.beginRefreshingBlock=^(){
//            // 后台执行：
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                sleep(2);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    typeof(weakRefreshFooter) __strong strongRefreshFooter = weakRefreshFooter;
//                    // 主线程刷新视图
//                    [tableView reloadData];
//                    [strongRefreshFooter endRefreshing];
//                });
//            });
//        };
    }
//
//    // 是否在进入该界面的时候就开始进入刷新状态
//    [refreshHeader beginRefreshing];
    
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
    } else if (indexPath.row == 2) {
        
        TestScrollViewController *testScrollVc = [[TestScrollViewController alloc] init];
        testScrollVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:testScrollVc animated:YES];
    }
}

- (NSMutableArray *)dataSourceArr {
    
    if (!_dataSourceArr) {
        
        _dataSourceArr = [NSMutableArray array];
        
        NSArray *arr = @[@"TableView Test",@"CollectionView Test", @"ScrollView Test"];
        
        for (NSInteger i = 0; i < 300; i++) {
            
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


- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 圆角弧度半径
    CGFloat cornerRadius = 6.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = UIColor.clearColor;
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 10, 0);
    
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    if (indexPath.row == 0) {
        // 初始起点为cell的左下角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectedBackgroundView;
    
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
