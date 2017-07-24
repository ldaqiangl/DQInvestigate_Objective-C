//
//  DQScroll3DFlowLayout.m
//  DQInvestigate
//
//  Created by 董富强 on 2017/7/24.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQScroll3DFlowLayout.h"

@interface DQScroll3DFlowLayout ()
{
    CGFloat _totalWidth;
    CGFloat _totalHeight;
}

@end

@implementation DQScroll3DFlowLayout

- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)prepareLayout {
    
    _totalWidth = self.collectionView.width_DQExt;
    _totalHeight = self.collectionView.height_DQExt;
    
    self.itemSize = CGSizeMake(_totalWidth * 2 / 3, _totalHeight * 0.8);
}




@end












