//
//  UILabel+DNCustom.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DNCustom)

/**
 *  lable
 *
 *  @param frame           大小
 *  @param text            文字
 *  @param font            字体
 *  @param color           字体颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return lable
 */
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor*)color backGroundColor:(UIColor*)backGroundColor;

/**
 *  Lable
 *
 *  @param frame           大小
 *  @param text            文字
 *  @param font            字体
 *  @param color           字体颜色
 *  @param backGroundColor 背景颜色
 *  @param align           对齐方向
 *
 *  @return lable
 */
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor*)color backGroundColor:(UIColor*)backGroundColor textAlignment:(NSTextAlignment)align;

@end
