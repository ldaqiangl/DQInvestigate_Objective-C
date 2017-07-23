//
//  BSMultiMenuView.m
//  HXInvestigate
//
//  Created by 董富强 on 16/8/30.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "BSMultiMenuView.h"

//------------------------------ 分割线 ------------------------------

//控制 被选择的选项 缩放显示
static const CGFloat targetXScale = 1.2;
static const CGFloat normalXScale = 1.0;
static const CGFloat targetYScale = 1.1;
static const CGFloat normalYScale = 1.0;

@interface BSMultiMenuView ()
<UIScrollViewDelegate>
{
    NSInteger _prePageIndex;
}

@property (nonatomic, strong) NSMutableArray *allTitleBtnsArr;

@property (nonatomic, weak) UIScrollView *titlesScrollView;
@property (nonatomic, weak) UIScrollView *pagesScrollView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *pageControllersArr;

@end

@implementation BSMultiMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.allTitleBtnsArr = [NSMutableArray array];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    CGFloat menuW = self.bounds.size.width;
    CGFloat menuH = self.bounds.size.height;
    
    CGFloat titleH = 36.0;
    CGFloat pageH = menuH - titleH;
    
    UIScrollView *titlesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, menuW, titleH)];
    titlesScrollView.delegate = self;
    titlesScrollView.showsVerticalScrollIndicator = NO;
    titlesScrollView.showsHorizontalScrollIndicator = NO;
    self.titlesScrollView = titlesScrollView;
    [self addSubview:titlesScrollView];
    
    UIScrollView *pagesScrollView =
    [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titlesScrollView.frame), menuW, pageH)];
    pagesScrollView.delegate = self;
    pagesScrollView.pagingEnabled = YES;
    pagesScrollView.showsVerticalScrollIndicator = NO;
    pagesScrollView.showsHorizontalScrollIndicator = NO;
    self.pagesScrollView = pagesScrollView;
    [self addSubview:pagesScrollView];
    
    
    titlesScrollView.backgroundColor = [UIColor whiteColor];
    pagesScrollView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - <数据源赋值> -

- (void)setTitlesArr:(NSMutableArray *)titlesArr {
    
    if (self.allTitleBtnsArr) {
        [self.allTitleBtnsArr removeAllObjects];
        for (UIButton *btn in self.titlesScrollView.subviews) {
            [btn removeFromSuperview];
        }
    }
    
    //1.titles
    UIFont *titleFont = [UIFont systemFontOfSize:14.0];
    
    CGFloat titleSpace = 20;
    CGFloat titleX = titleSpace, titleY = 0;
    CGFloat titleW = 0, titleH = CGRectGetHeight(_titlesScrollView.frame);
    
    CGSize titleContentSize = CGSizeMake(titleW, titleH);
    
    for (int i = 0;i < titlesArr.count; i++) {
        
        NSString *titleStr = titlesArr[i];
        titleW = [titleStr sizeWithAttributes:@{NSFontAttributeName:titleFont}].width;
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(titleX, titleY, titleW, titleH);
        [titleBtn setTitle:titleStr forState:UIControlStateNormal];
        titleBtn.titleLabel.font = titleFont;
        [titleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor brownColor] forState:UIControlStateSelected];
        titleBtn.backgroundColor = [UIColor whiteColor];
        [titleBtn addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesScrollView addSubview:titleBtn];
        [self.allTitleBtnsArr addObject:titleBtn];
        
        titleX += (titleW+titleSpace);
        titleContentSize.width = CGRectGetMaxX(titleBtn.frame)+titleSpace;
    }
    
    _titlesScrollView.contentSize = titleContentSize;
    
    
    //2.pages
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i = 0; i < titlesArr.count; i++) {
        TableListViewController *tableList1 = [[TableListViewController alloc] init];
        [vcArr addObject:tableList1];
    }
    self.pageControllersArr = vcArr;
}

- (void)setPageControllersArr:(NSMutableArray *)pageControllersArr {
    
    _pageControllersArr = pageControllersArr;
    
    //page
    CGFloat pageW = self.bounds.size.width, pageH
    = CGRectGetHeight(_pagesScrollView.frame);
    
    CGFloat pageX = 0, pageY = 0;
    
    CGSize pageContentSize = CGSizeMake(pageW, pageH);
    for (int i = 0; i < pageControllersArr.count; i++) {
        
        RootListViewController *rootVc = [pageControllersArr objectAtIndex:i];
        rootVc.view.frame = CGRectMake(pageX, pageY, pageW, pageH);
        [_pagesScrollView addSubview:rootVc.view];
        
        [self.managerVc addChildViewController:rootVc];
        [rootVc didMoveToParentViewController:self.managerVc];
        rootVc.managerVc = self.managerVc;
        [self.managerVc addObserver:rootVc forKeyPath:@"listState" options:NSKeyValueObservingOptionNew context:nil];
        
        pageX += pageW;
        pageContentSize.width = CGRectGetMaxX(rootVc.view.frame);
    }
    
    _pagesScrollView.contentSize = pageContentSize;
    
    [self someVcListViewDidAppear:0];
}


#pragma mark - <点击导航选择按钮们> -
- (void)titleButtonClicked:(UIButton *)sender {
    
    [self changeTitleButtonState:sender];
    
    CGFloat pageW = self.bounds.size.width;
    NSInteger titleIndex = [self.allTitleBtnsArr indexOfObject:_selectedBtn];
    [self.pagesScrollView setContentOffset:CGPointMake(titleIndex*pageW, 0) animated:YES];
    
    [self calAndMoveSelectedBtnToMidWith:titleIndex];
    
    [self someVcListViewDidAppear:titleIndex];
}

- (void)changeTitleButtonState:(UIButton *)sender {
    
    if (!sender.selected) {
        _selectedBtn.selected = NO;
        _selectedBtn.transform = CGAffineTransformMakeScale(normalXScale, normalYScale);;
        _selectedBtn = sender;
        sender.selected = YES;
        sender.transform = CGAffineTransformMakeScale(targetXScale, targetYScale);
    }
}



#pragma mark - <UIScrollViewDelegate> -

/** 滑动减速停止 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offX = scrollView.contentOffset.x;
    
    if (scrollView == self.titlesScrollView) {
        
    } else {
        
        //1.选中与页面相对应的标题 并改变其状态
        CGFloat pageW = self.bounds.size.width;
        NSInteger pageIndex = roundf(offX / pageW);
        [self changeTitleButtonState:[self.allTitleBtnsArr objectAtIndex:pageIndex]];
        
        //2.
        [self calAndMoveSelectedBtnToMidWith:pageIndex];
        
        //3.
        [self someVcListViewDidAppear:pageIndex];
    }
    
}

/** 让标题是否居中计算 */
- (void)calAndMoveSelectedBtnToMidWith:(NSInteger)pageIndex {
    CGFloat titleScrollW = CGRectGetWidth(_titlesScrollView.frame);
    CGFloat midDisplayOffX = _selectedBtn.center.x-titleScrollW*0.5;
    CGFloat contentViewW = _titlesScrollView.contentSize.width;
    
    if (midDisplayOffX > 0 && midDisplayOffX < contentViewW-titleScrollW) {
        [_titlesScrollView setContentOffset:CGPointMake(midDisplayOffX, 0) animated:YES];
    } else {
        if (midDisplayOffX >= contentViewW-titleScrollW) {
            [_titlesScrollView setContentOffset:CGPointMake(contentViewW-titleScrollW, 0) animated:YES];
        } else if (midDisplayOffX <= 0) {
            [_titlesScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

/** 选择某一个页面需要展示的时候 调用该页面对应控制器的加载方法 */
- (void)someVcListViewDidAppear:(NSInteger)pageIndex {
    
    TableListViewController *listVc = self.pageControllersArr[pageIndex];
    [listVc listViewDidAppear];
}

@end
