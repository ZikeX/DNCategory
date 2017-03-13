//
//  UITextField+DNCustom.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UITextField+DNCustom.h"

@implementation UITextField (DNCustom)

- (void)addLeftViewWithImage:(NSString *)image {
    // 密码输入框左边图片
    UIImageView *lockIv   = [[UIImageView alloc] init];
    // 设置尺寸
    CGRect imageBound     = self.bounds;
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds         = imageBound;
    // 设置图片
    lockIv.image          = [UIImage imageNamed:image];
    // 设置图片居中显示
    lockIv.contentMode    = UIViewContentModeCenter;
    // 添加TextFiled的左边视图
    self.leftView         = lockIv;
    // 设置TextField左边的总是显示
    self.leftViewMode     = UITextFieldViewModeAlways;
}


+ (UITextField*)textFieldWithFrame:(CGRect)frame
                         alignment:(NSTextAlignment)alignment
                       placeholder:(NSString*)placeholder
                       borderStyle:(UITextBorderStyle)borderStyle delegate:(id<UITextFieldDelegate>)vc{
    UITextField * text            = [[UITextField alloc]initWithFrame:frame];
    [text setTextAlignment:alignment];
    text .text                    = @"";
    text.backgroundColor          = [UIColor clearColor];
    [text setBorderStyle:borderStyle];//设置属性
    text.placeholder              = placeholder;//设置提示文字
    text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置字体垂直居中
    text.delegate                 = vc;
    return text;
    
}

@end
