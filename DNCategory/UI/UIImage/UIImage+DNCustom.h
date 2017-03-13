//
//  UIImage+DNCustom.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DNCustom)

/**
 *  截图指定view成图片
 *
 *  @param view 一个view
 *
 *  @return 图片
 */
+ (UIImage *)captureWithView:(UIView *)view;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 获得指定size的图片

 @param image 原始图片
 @param size 最大大小 kb
 @return 调整后的图片
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

/**
 *  获取一个可拉伸的UIImage
 *
 *  @param imageName 图片名称
 *
 *  @return Image
 */
+ (UIImage *)streImageNamed:(NSString *)imageName;
+ (UIImage *)streImageNamed:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y;

/**
 *  中心拉伸图片
 *
 *  @param name 图片名字
 *
 *  @return 图片
 */
+ (UIImage *)stretchedImageWithName:(NSString *)name;

/**
 *  通过链接生成二维码图片
 *
 *  @param qrString 链接地址
 *  @param size     图片大小
 *
 *  @return 生成的二维码图片
 */
+ (UIImage *)createQRForString:(NSString *)qrString withSize:(CGFloat)size;

/**
 *  获得的就是一个圆形的图片
 */
- (UIImage *)getCircleImage;

/**
 *  根据bundle中的文件名读取图片
 *
 *  @param name 图片名
 *
 *  @return 无缓存的图片
 */
+ (UIImage *)imageWithFileName:(NSString *)name;

@end
