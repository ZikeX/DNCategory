//
//  UITextView+DNPinchZoom.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (DNPinchZoom)

@property (nonatomic) CGFloat maxFontSize, minFontSize;

@property (nonatomic, getter = isZoomEnabled) BOOL zoomEnabled;

@end
