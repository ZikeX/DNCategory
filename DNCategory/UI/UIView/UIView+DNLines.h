//
//  UIView+DNLines.h
//  DNCommunity
//
//  Created by mainone on 2017/2/15.
//  Copyright © 2017年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DNLineDirection) {
    DNLineDirectionLeft   = 1 << 0,
    DNLineDirectionRight  = 1 << 1,
    DNLineDirectionTop    = 1 << 2,
    DNLineDirectionBottom = 1 << 3,
    DNLineDirectionAll    = 1 << 4
};

typedef NS_ENUM(NSInteger, DNLineType) {
    // default
    DNLineTypeFill    = 1 << 0,
    // 短一点的线 (70%)
    DNLineTypeShort   = 1 << 1,
    // 虚线
    DNLineTypeDotted  = 1 << 2
};


@interface UIView (DNLines)

/**
 *  完整方法:
 *  direction 线的方向，可多选,
 *  type      线的样式，虚线可与其它多选,
 *  lineWidth 线的宽度,
 *  lineColor 线的颜色
 */
- (void)dn_addLineWithDirection:(DNLineDirection)direction
                           type:(DNLineType)type
                      lineWidth:(CGFloat)lineWidth
                      lineColor:(UIColor *)lineColor;

/**
 *  默认线颜色(黑色)
 */
- (void)dn_addLineWithDirection:(DNLineDirection)direction
                           type:(DNLineType)type
                      lineWidth:(CGFloat)lineWidth;

/**
 *  默认线颜色(黑色),
 *  默认线样式(DNLineTypeFill)
 */
- (void)dn_addLineWithDirection:(DNLineDirection)direction
                      lineWidth:(CGFloat)lineWidth;

/**
 *  默认线颜色(黑色),
 *  默认线样式(DNLineTypeFill),
 *  默认线宽度(2)
 */
- (void)dn_addLineWithDirection:(DNLineDirection)direction;


@end
