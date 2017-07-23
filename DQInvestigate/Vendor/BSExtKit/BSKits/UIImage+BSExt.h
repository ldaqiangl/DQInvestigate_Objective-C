//
//  UIImage+BSExt.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BSExt)

/**
 *  根据颜色生成响应的图片
 *
 * @param color 颜色值
 *
 * @return 返回图片对象
 */
+ (UIImage *)imageWithColor_Ext:(UIColor *)color;

/**
 *	加载图片
 *  @param name 图片的名字,会自动在图片后缀上添加“topic_Ext”,"UIApplication+ExtensionExt"的扩展的字段
 *  @return 返回图片对象
 */
+ (UIImage *)imageNamed_Ext:(NSString *)name;

/**
 *  路径加载图片
 *
 * @param path 图片的路径，会自动在图片后缀前，添加topic_Ext("UIApplication+ExtensionExt"的扩展的属性)的字段名
 *
 * @return 图片对象
 */
+ (UIImage *)imageWithContentsOfFile_Ext:(NSString *)path;

/**
 *  从图片中截取图片
 *
 * @param rect 是截图图片的位置和大小
 *
 * @return 图片对象
 */
- (UIImage *)creatNewImageInRect_Ext:(CGRect )rect;

/**
 *  将UIImage缩放到指定大小尺寸
 *
 * @param size 得到的图片尺寸大小
 *
 * @return 图片对象
 */
- (UIImage *)imageZoomToSize_Ext:(CGSize)size;

/**
 *  按比例， 将UIImage“按比例”缩放到指定大小尺寸
 *
 * @param size 指定图片的大小
 *
 * @return 图片对象
 */
-(UIImage *) imageScalZoonToSize_Ext:(CGSize)size;

/**
 *  按比例， 将UIImage“按比例”缩放到指定大小尺寸
 *
 * @param defineWidth 指定图片的宽度
 *
 * @return 图片对象
 */
-(UIImage *) imageScalZoonToWidth_Ext:(CGFloat)defineWidth;


/**
 * 将图片切成圆角图片
 *
 * @param size 返回图片的大小
 * @param r 圆角的大小
 *
 * @return 图片对象
 */
- (UIImage *)imageWithRoundedSize:(CGSize)size radius:(NSInteger)r;

/*
 UIImage *animation = [UIImage animatedImageWithAnimatedGIFData:theData];
 
 I interpret `theData` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
 
 The GIF stores a separate duration for each frame, in units of centiseconds (hundredths of a second).  However, a `UIImage` only has a single, total `duration` property, which is a floating-point number.
 
 To handle this mismatch, I add each source image (from the GIF) to `animation` a varying number of times to match the ratios between the frame durations in the GIF.
 
 For example, suppose the GIF contains three frames.  Frame 0 has duration 3.  Frame 1 has duration 9.  Frame 2 has duration 15.  I divide each duration by the greatest common denominator of all the durations, which is 3, and add each frame the resulting number of times.  Thus `animation` will contain frame 0 3/3 = 1 time, then frame 1 9/3 = 3 times, then frame 2 15/3 = 5 times.  I set `animation.duration` to (3+9+15)/100 = 0.27 seconds.
 * 播放GIF图片，放到imageView里面自动播放；
 * @param theData GIF图片的data
 * @return 返回一个GIF的图片
 */
+ (UIImage *)animatedImageWithAnimatedGIFData_Ext:(NSData *)theData;

/*
 UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:theURL];
 
 I interpret the contents of `theURL` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
 
 I operate exactly like `+[UIImage animatedImageWithAnimatedGIFData:]`, except that I read the data from `theURL`.  If `theURL` is not a `file:` URL, you probably want to call me on a background thread or GCD queue to avoid blocking the main thread.
 * 播放GIF图片，放到imageView里面自动播放；
 * @param theURL GIF图片的URL
 * @return 返回一个GIF的图片
 */
+ (UIImage *)animatedImageWithAnimatedGIFURL_Ext:(NSURL *)theURL;


/**
 * 得到图片上某点的颜色
 *
 * @param 图片的点的位置
 *
 * @return 颜色
 */
- (UIColor *)colorAtPixel_Ext:(CGPoint)point;


/**
 * 把图片旋转到指定角度
 *
 * @param degrees 旋转的度数,如：330
 *
 * @return 选择后的图片
 */
- (UIImage *)imageRotatedByDegrees_Ext:(CGFloat)degrees;


/**
 *  旋转生成图片方向为正上正下方向
 */
+ (UIImage *)imageFixOrientation_Ext:(UIImage *)srcImg;


/**
 *  生成高斯模糊效果的图片
 *
 *  @param radius     <#radius description#>
 *  @param iterations <#iterations description#>
 *  @param tintColor  <#tintColor description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)imageBlurredWithRadius_Ext:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

@end
