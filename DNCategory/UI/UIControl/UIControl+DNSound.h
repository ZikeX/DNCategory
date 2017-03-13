//
//  UIControl+DNSound.h
//  DNCategory
//
//  Created by mainone on 16/6/6.
//  Copyright © 2016年 wjn. All rights reserved.


//  记得把AVFoundation.framework依赖库

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIControl (DNSound)

/**
 *  点击事件的声音
 *
 *  @param name         音频名字
 *  @param controlEvent 点击事件类型
 */
- (void)setSoundName:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;

@end
