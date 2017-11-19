//
//  DQScroll3DFlowLayout.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/7/24.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQScroll3DFlowLayout.h"

#define ZOOM_FACTOR 0.1

@interface DQScroll3DFlowLayout ()
{
    CGFloat ACTIVE_DISTANCE;
    CGFloat _totalWidth;
    CGFloat _totalHeight;
}

@end

@implementation DQScroll3DFlowLayout

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    _totalWidth = self.collectionView.width_DQExt;
    _totalHeight = self.collectionView.height_DQExt;
    
    self.itemSize = CGSizeMake(_totalWidth * 0.6, _totalHeight * 0.8);
    ACTIVE_DISTANCE = _totalWidth*0.5;
    self.minimumLineSpacing = 15;
    
    self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

- (CGSize)collectionViewContentSize {
    
    NSInteger itemCount =
    [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    
    CGFloat coWidth = self.minimumLineSpacing * (itemCount + 1) + itemCount * self.itemSize.width;
    
    return CGSizeMake(coWidth, self.collectionView.height_DQExt);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    //NSLog(@"shouldInvalidateLayoutForBoundsChange");
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            distance = ABS(distance);
            
//            if (distance < DQSCREEN_WIDTH * 0.5 + self.itemSize.width) {
            
                attributes.transform3D = CATransform3DIdentity;
                
                CGFloat zoom = 1 + ZOOM_FACTOR * (1 - distance / ACTIVE_DISTANCE);
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                //attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0 , -zoom * 25, 0);
                attributes.alpha = zoom - ZOOM_FACTOR;
//            }
        }
    }
    
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect =
    CGRectMake(proposedContentOffset.x, 0.0,
               self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}






@end












