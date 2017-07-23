//
//  BSCycleCollectionCell.m
//  HXInvestigate
//
//  Created by 董富强 on 16/9/6.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "BSCycleCollectionCell.h"

@implementation BSCycleCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 8.0;
    _imageView = imageView;
    _imageView.frame = self.bounds;
    [self.contentView addSubview:imageView];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.indexLabel = l;
    [self.contentView addSubview:self.indexLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}


@end
