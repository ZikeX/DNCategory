//
//  UILabel+DNCustom.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UILabel+DNCustom.h"

@implementation UILabel (DNCustom)

+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor*)color backGroundColor:(UIColor*)backGroundColor {
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    [label setFont:font];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.textColor = color;
    label.backgroundColor = backGroundColor;
    return label;
}

+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor*)color backGroundColor:(UIColor*)backGroundColor textAlignment:(NSTextAlignment)align {
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    [label setFont:font];
    [label setTextAlignment:align];
    label.textColor = color;
    label.backgroundColor = backGroundColor;
    return label;
}

@end
