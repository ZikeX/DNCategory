//
//  UIImage+DNBlock.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DNBlock)

// 保存相册
- (void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock;

@end
