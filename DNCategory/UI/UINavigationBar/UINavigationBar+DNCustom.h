//
//  UINavigationBar+DNCustom.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (DNCustom)

/**
 *  设置背景颜色
 *
 *  @param backgroundColor 背景颜色
 */
- (void)RsetBackgroundColor:(UIColor *)backgroundColor;

/**
 *  设置透明度
 *
 *  @param alpha 透明度
 */
- (void)RsetElementsAlpha:(CGFloat)alpha;

/**
 *  设置导航栏Y值
 *
 *  @param translationY Y坐标
 */
- (void)RsetTranslationY:(CGFloat)translationY;

/**
 *  导航栏样式重置
 */
- (void)Rreset;

// 显示导航栏下面的分割线
- (void)showNavigationBarBottomLineView;

// 隐藏导航栏下面的分割线
- (void)hiddenNavigationBarBottomLineView;

@end
