//
//  BSCycleScrollView.m
//  HXInvestigate
//
//  Created by 董富强 on 16/9/2.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "BSCycleScrollView.h"
#import "BSCycleLayout.h"
#import "BSCycleCollectionCell.h"
#import "UIImageView+WebCache.h"
NSString * const BS_CELL_ID = @"cycleCell";

@interface BSCycleScrollView ()
<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;

@property (nonatomic, strong) BSCycleLayout *cycleLayout;
@property (nonatomic, weak) UICollectionView *mainView;

@end

@implementation BSCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupView];
    }
    return self;
}

- (void)initialization {
    
    _autoScrollTimeInterval = 3.0;
    _infiniteLoop = YES;
    _totalItemsCount = 0;
//    [self setupTimer];
    
}

- (void)setupView {
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    _cycleLayout = [[BSCycleLayout alloc] init];
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_cycleLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[BSCycleCollectionCell class] forCellWithReuseIdentifier:BS_CELL_ID];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    _mainView = mainView;
    
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<BSCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage {
    
    BSCycleScrollView *cycleScrollView = [[BSCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    cycleScrollView.placeholderImage = placeholderImage;
    
    
    return cycleScrollView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        } else {
            targetIndex = 0;
        }
        
    }
}


#pragma mark - <数据赋值和更新> -
- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup {
    
    [self invalidateTimer];
    
    _imageURLStringsGroup = imageURLStringsGroup;
    
    _totalItemsCount = imageURLStringsGroup.count * 10;
    
    [_mainView reloadData];
    
    [self scrollToIndex:_totalItemsCount*0.5];
}



#pragma mark - <UICollectionViewDelegate & UICollectionViewDataSource> -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *imgUrl = [_imageURLStringsGroup objectAtIndex:indexPath.item%_imageURLStringsGroup.count];
    
    BSCycleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BS_CELL_ID forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


#pragma mark - <辅助> -
- (void)setupTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
//释放计时器
- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)automaticScroll {
    if (0 == _totalItemsCount) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (int)currentIndex {
    if (_mainView.frameWidth_Ext == 0 || _mainView.frameHeight_Ext == 0) {
        return 0;
    }
    
    int index = 0;
    if (_cycleLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        index = (_mainView.contentOffset.x + _mainView.frameWidth_Ext * 0.5 - _cycleLayout.itemSize.width*0.5) / (_cycleLayout.itemSize.width+_cycleLayout.minimumLineSpacing);
        
    } else {
        index = (_mainView.contentOffset.y + _cycleLayout.itemSize.height * 0.5) / _cycleLayout.itemSize.height;
    }

    return MAX(0, index);
}

- (void)scrollToIndex:(NSInteger)targetIndex {
    CGFloat offX;
    if (targetIndex<_totalItemsCount) {
        
        offX = (targetIndex+1)*(_cycleLayout.itemSize.width+_cycleLayout.minimumLineSpacing)-_cycleLayout.itemSize.width*0.5-self.mainView.frameWidth_Ext*0.5-_cycleLayout.minimumLineSpacing+_cycleLayout.sectionInset.left;
        [self.mainView setContentOffset:CGPointMake(offX, self.mainView.contentOffset.y) animated:YES];
    } else {
        offX = 0;
        [self.mainView setContentOffset:CGPointMake(offX, self.mainView.contentOffset.y)];
    }
}

@end
