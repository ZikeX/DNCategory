//
//  UIImageView+DNAnimation.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIImageView+DNAnimation.h"

@implementation UIImageView (DNAnimation)

+ (id)imageViewWithImageNamed:(NSString*)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

+ (id) imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration {
    if (imageArray && !([imageArray count]>0)) {
        return nil;
    }
    UIImageView *imageView = [UIImageView imageViewWithImageNamed:[imageArray objectAtIndex:0]];
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [images addObject:image];
    }
    [imageView setImage:[images objectAtIndex:0]];
    [imageView setAnimationImages:images];
    [imageView setAnimationDuration:duration];
    [imageView setAnimationRepeatCount:0];
    return imageView;
}


@end
