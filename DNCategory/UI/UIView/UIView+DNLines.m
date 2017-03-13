//
//  UIView+DNLines.m
//  DNCommunity
//
//  Created by mainone on 2017/2/15.
//  Copyright © 2017年 mainone. All rights reserved.
//

#import "UIView+DNLines.h"
#define DN_Line_Short_Scale 0.7

@implementation UIView (DNLines)

- (void)dn_addLineWithDirection:(DNLineDirection)direction
                           type:(DNLineType)type
                      lineWidth:(CGFloat)lineWidth
                      lineColor:(UIColor *)lineColor {
    if((direction & DNLineDirectionTop))  {
        [self addTopLineForType:type lineWidth:lineWidth lineColor:lineColor];
    }
    
    if((direction & DNLineDirectionBottom)) {
        [self addBottomLineForType:type lineWidth:lineWidth lineColor:lineColor];
    }
    
    if((direction & DNLineDirectionLeft)) {
        [self addLeftLineForType:type lineWidth:lineWidth lineColor:lineColor];
    }
    
    if((direction & DNLineDirectionRight)) {
        [self addRightLineForType:type lineWidth:lineWidth lineColor:lineColor];
    }
    if (direction & DNLineDirectionAll) {
        [self addTopLineForType:type lineWidth:lineWidth lineColor:lineColor];
        [self addBottomLineForType:type lineWidth:lineWidth lineColor:lineColor];
        [self addLeftLineForType:type lineWidth:lineWidth lineColor:lineColor];
        [self addRightLineForType:type lineWidth:lineWidth lineColor:lineColor];
    }
}

- (void)addLeftLineForType:(DNLineType)type lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor{
    NSLog(@"左");
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    if (type & DNLineTypeFill) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    } else if (type & DNLineTypeShort) {
        CGFloat space = (self.frame.size.height * (1 - DN_Line_Short_Scale))/2.0;
        [path moveToPoint:CGPointMake(0, space)];
        [path addLineToPoint:CGPointMake(0, self.frame.size.height - space)];
    }
    
    CAShapeLayer * borderLayer = [self setShapeLayerWithType:type lineWidth:lineWidth lineColor:lineColor];
    borderLayer.path = path.CGPath;
    [self.layer addSublayer:borderLayer];
    
}

- (void)addRightLineForType:(DNLineType)type lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    NSLog(@"右");
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    if (type & DNLineTypeFill) {
        [path moveToPoint:CGPointMake(self.frame.size.width, 0)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    } else if (type & DNLineTypeShort) {
        CGFloat space = (self.frame.size.height * (1 - DN_Line_Short_Scale))/2.0;
        [path moveToPoint:CGPointMake(self.frame.size.width, space)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - space)];
    }
    
    CAShapeLayer * borderLayer = [self setShapeLayerWithType:type lineWidth:lineWidth lineColor:lineColor];
    borderLayer.path = path.CGPath;
    [self.layer addSublayer:borderLayer];
}

- (void)addTopLineForType:(DNLineType)type lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    NSLog(@"上");
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    if (type & DNLineTypeFill) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    } else if (type & DNLineTypeShort) {
        CGFloat space = (self.frame.size.height * (1 - DN_Line_Short_Scale))/2.0;
        [path moveToPoint:CGPointMake(space, 0)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - space, 0)];
    }
    
    CAShapeLayer * borderLayer = [self setShapeLayerWithType:type lineWidth:lineWidth lineColor:lineColor];
    borderLayer.path = path.CGPath;
    [self.layer addSublayer:borderLayer];
}

- (void)addBottomLineForType:(DNLineType)type lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    NSLog(@"下");
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    if (type & DNLineTypeFill) {
        [path moveToPoint:CGPointMake(0, self.frame.size.height)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    } else if (type & DNLineTypeShort) {
        CGFloat space = (self.frame.size.height * (1 - DN_Line_Short_Scale))/2.0;
        [path moveToPoint:CGPointMake(space, self.frame.size.height)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - space, self.frame.size.height)];
    }
    
    CAShapeLayer * borderLayer = [self setShapeLayerWithType:type lineWidth:lineWidth lineColor:lineColor];
    borderLayer.path = path.CGPath;
    [self.layer addSublayer:borderLayer];
}

- (CAShapeLayer *)setShapeLayerWithType:(DNLineType)type
                              lineWidth:(CGFloat)lineWidth
                              lineColor:(UIColor *)lineColor {
    CAShapeLayer * borderLayer = [CAShapeLayer layer];
    borderLayer.fillColor   = lineColor.CGColor;
    borderLayer.strokeColor = lineColor.CGColor;
    if ((type & DNLineTypeDotted)) {
        //虚线边框
        borderLayer.lineDashPattern = @[@8, @8];
    } else {
        //实线边框
        borderLayer.lineDashPattern = nil;
    }
    return borderLayer;
}


- (void)dn_addLineWithDirection:(DNLineDirection)direction
                            type:(DNLineType)type
                       lineWidth:(CGFloat)lineWidth {
    [self dn_addLineWithDirection:direction type:type lineWidth:lineWidth lineColor:[UIColor blackColor]];
}

- (void)dn_addLineWithDirection:(DNLineDirection)direction
                       lineWidth:(CGFloat)lineWidth {
    [self dn_addLineWithDirection:direction type:DNLineTypeFill lineWidth:lineWidth lineColor:[UIColor blackColor]];
}

- (void)dn_addLineWithDirection:(DNLineDirection)direction {
    [self dn_addLineWithDirection:direction type:DNLineTypeFill lineWidth:2 lineColor:[UIColor blackColor]];
}


@end
