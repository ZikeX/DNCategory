//
//  UIImage+DNOrientation.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DNOrientation)

/**
 *  修正图片的方向
 *
 *  @param srcImg 图片
 *
 *  @return 修正后的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)srcImg;

/**
 *  旋转图片
 *
 *  @param degrees 角度
 *
 *  @return 旋转后图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  角度转弧度
 *
 *  @param degrees 角度
 *
 *  @return 弧度
 */
+ (CGFloat)degreesToRadians:(CGFloat)degrees;

/**
 *  弧度转角度
 *
 *  @param radian 弧度
 *
 *  @return 角度
 */
+ (CGFloat)radianToDegrees:(CGFloat)radian;

@end
