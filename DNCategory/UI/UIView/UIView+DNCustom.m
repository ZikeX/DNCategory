//
//  UIView+DNCustom.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIView+DNCustom.h"

@interface DNCorner ()

@end

@implementation DNCorner

+ (CGFloat)ceilbyunit:(CGFloat)num unit:(double)unit {
    return num - modf(num, &unit) + unit;
}

+ (CGFloat)floorbyunit:(CGFloat)num unit:(double)unit {
    return num - modf(num, &unit);
}

+ (CGFloat)roundbyunit:(CGFloat)num unit:(double)unit {
    CGFloat remain = modf(num, &unit);
    if (remain > unit / 2.0) {
        return [self ceilbyunit:num unit:unit];
    } else {
        return [self floorbyunit:num unit:unit];
    }
}

+ (CGFloat)pixel:(CGFloat)num {
    CGFloat unit;
    CGFloat scale = [[UIScreen mainScreen] scale];
    switch ((NSInteger)scale) {
        case 1:
            unit = 1.0 / 1.0;
            break;
        case 2:
            unit = 1.0 / 2.0;
            break;
        case 3:
            unit = 1.0 / 3.0;
            break;
        default:
            unit = 0.0;
            break;
    }
    return [self roundbyunit:num unit:unit];
}


@end

@implementation UIView (DNCustom)

- (UIView *)getViewWithXibName:(NSString *)name withIndex:(NSInteger)index {
    NSArray *nib          = [[NSBundle mainBundle]loadNibNamed:name owner:self options:nil];
    UIView *tmpCustomView = [nib objectAtIndex:index];
    return tmpCustomView;
}

- (UIViewController *)getSuperViewController {
    UIViewController *superVC = nil;
    id temp = nil;
    UIView *tempView = self;
    do {
        tempView = tempView.superview;
        temp     = tempView.nextResponder;
        superVC  = temp;
    } while (![temp isKindOfClass:[UIViewController class]]);
    
    return superVC;
}

- (void)addEffectWithBorderColor:(UIColor*)borderColor borderWidth:(float)borderWidth {
    self.layer.borderColor = [borderColor CGColor];
    self.layer.borderWidth = borderWidth;
}

- (void)addEffectWithShadowRadius:(float)radius shadowOffset:(CGSize)offset shadowOpacity:(float)opacity shadowColor:(UIColor*)shadowColor {
    if (self.clipsToBounds)self.clipsToBounds = NO;
    self.layer.shadowColor                    = shadowColor.CGColor;
    self.layer.shadowRadius                   = radius;
    self.layer.shadowOffset                   = offset;
    self.layer.shadowOpacity                  = opacity;
    self.layer.shadowPath =[UIBezierPath bezierPathWithRect:self.bounds].CGPath;//防止卡顿
}

// 模糊效果
- (void)addBlurwithAlpha:(float)alpha style:(UIBlurEffectStyle)style {
    UIBlurEffect *effect     = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *test = [[UIVisualEffectView alloc] initWithEffect:effect];
    test.frame               = self.bounds;
    test.alpha               = alpha;
    [self addSubview:test];
}

- (void)addCornerWithRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners {
    UIBezierPath *maskPath  = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}

- (void)addCornerRadius:(CGFloat)radius {
    [self addCornerRadius:radius
                 borderWidth:1.0f
             backgroundColor:[UIColor whiteColor]
                borderCorlor:[UIColor blackColor]];
}

- (void)addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
           backgroundColor:(UIColor *)backgroundColor
              borderCorlor:(UIColor *)borderColor {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self drawRectWithRoundedCornerRadius:radius
                                                                                             borderWidth:borderWidth
                                                                                         backgroundColor:backgroundColor
                                                                                            borderCorlor:borderColor]];
    
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)drawRectWithRoundedCornerRadius:(CGFloat)radius
                                    borderWidth:(CGFloat)borderWidth
                                backgroundColor:(UIColor *)backgroundColor
                                   borderCorlor:(UIColor *)borderColor {
    CGSize sizeToFit = CGSizeMake([DNCorner pixel:self.bounds.size.width], self.bounds.size.height);
    CGFloat halfBorderWidth = borderWidth / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    
    CGFloat width = sizeToFit.width, height = sizeToFit.height;
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth); // 准备开始移动坐标
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius);
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


@end
