//
//  UITextField+DNCustom.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (DNCustom)

/**
 *  左侧显示图片
 *
 *  @param image 图片
 */
- (void)addLeftViewWithImage:(NSString *)image;

/**
 *  TextField
 *
 *  @param frame       大小
 *  @param alignment   对齐方式
 *  @param placeholder 默认文字
 *  @param borderStyle 样式
 *  @param vc          代理
 *
 *  @return TextField
 */
+ (UITextField*)textFieldWithFrame:(CGRect)frame
                        alignment:(NSTextAlignment)alignment
                      placeholder:(NSString*)placeholder
                      borderStyle:(UITextBorderStyle)borderStyle delegate:(id<UITextFieldDelegate>)vc;

@end
