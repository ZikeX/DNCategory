//
//  UIImageView+DNAnimation.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DNAnimation)

/**
 *  多张图片播放
 *
 *  @param imageArray 图片数组
 *  @param duration   持续时间
 *
 *  @return imageView
 */
+ (id)imageViewWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;

@end
