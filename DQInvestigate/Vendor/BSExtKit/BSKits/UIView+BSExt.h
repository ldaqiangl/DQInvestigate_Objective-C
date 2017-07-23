//
//  UIView+BSExt.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BSExt)
/**
 * @brief 获得视图的x值
 *
 * @return x值
 */
- (CGFloat)frameX_Ext;
- (void)setFrameX_Ext:(CGFloat)x;
/**
 * @brief 获得视图的y值
 *
 * @return y值
 */
- (CGFloat)frameY_Ext;
- (void)setFrameY_Ext:(CGFloat)y;
/**
 *	@brief	获取视图宽度
 *
 *	@return	宽度值（像素）
 */
- (CGFloat)frameWidth_Ext;
- (void)setFrameWidth_Ext:(CGFloat)w;
/**
 *	@brief	获取视图高度
 *
 *	@return	高度值（像素）
 */
- (CGFloat)frameHeight_Ext;
- (void)setFrameHeight_Ext:(CGFloat)h;


/**
 *	@brief	获取view的截图
 *
 *	@return	图片
 */
- (UIImage *)screenshot_Ext;


/**
 *	@brief	得到当前的第一响应者
 *
 *	@return	返回第一响应者，没有返回nil
 */
- (UIView *)currentFirstResponderView_Ext;


@end
