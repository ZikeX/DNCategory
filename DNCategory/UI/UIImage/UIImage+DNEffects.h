//
//  UIImage+DNEffects.h
//  ReadingGroup
//
//  Created by mainone on 16/7/14.
//  Copyright © 2016年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DNEffects)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


@end
