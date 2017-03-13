//
//  UIView+DNCustom.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNCorner : NSObject

@end

@interface UIView (DNCustom)

/**
 *  从xib获取视图
 *
 *  @param name  xib名字
 *  @param index 视图编号
 *
 *  @return 视图
 */
- (UIView *)getViewWithXibName:(NSString *)name withIndex:(NSInteger)index;

/**
 *  获取视图的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)getSuperViewController;

/**
 *  添加描边
 *
 *  @param borderColor 颜色
 *  @param borderWidth 大小
 */
- (void)addEffectWithBorderColor:(UIColor*)borderColor borderWidth:(float)borderWidth;

/**
 *  添加阴影
 *
 *  @param radius      阴影大小
 *  @param offset      偏移
 *  @param opacity     阴影透明度
 *  @param shadowColor 颜色
 */
- (void)addEffectWithShadowRadius:(float)radius shadowOffset:(CGSize)offset shadowOpacity:(float)opacity shadowColor:(UIColor*)shadowColor;

/**
 *  添加模糊效果
 *
 *  @param alpha 模糊程度 alpha越大越模糊
 *  @param style 模糊背景样式
 */
- (void)addBlurwithAlpha:(float)alpha style:(UIBlurEffectStyle)style;

/**
 *  给View添加圆角
 *
 *  @param radius  圆角大小
 *  @param corners 要变成圆角的地方
 */
- (void)addCornerWithRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;


/**
 *  给label, button, textfield等添加圆角，默认borderWidth = 1.0f, backgroundColor = whiteColor, borderColor = blackColor
 *
 *  @param radius 弧度
 */
- (void)addCornerRadius:(CGFloat)radius;


/**
 *  给label, button, textfield等添加圆角, 可以自定义其它的属性
 *
 *  @param radius          弧度
 *  @param borderWidth     borderWidth
 *  @param backgroundColor backgroundColor
 *  @param borderColor     borderColor
 */
- (void)addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
           backgroundColor:(UIColor *)backgroundColor
              borderCorlor:(UIColor *)borderColor;

@end
