//
//  UIButton+DNAddition.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DNAddition)

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title 如获取验证码
 *  @param subTitle 倒计时中的子名字，如时、分、秒
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/**
 *  图片文字上下排列居中对齐
 *
 *  @param spacing 上下间距
 */
- (void)middleAlignButtonWithSpacing:(CGFloat)spacing;

@end
