//
//  UITextView+DNPinchZoom.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UITextView+DNPinchZoom.h"
#import <objc/runtime.h>

static int minFontSizeKey;
static int maxFontSizeKey;
static int zoomEnabledKey;

@implementation UITextView (DNPinchZoom)


- (void)setMaxFontSize:(CGFloat)maxFontSize {
    objc_setAssociatedObject(self, &maxFontSizeKey, [NSNumber numberWithFloat:maxFontSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)maxFontSize {
     return [objc_getAssociatedObject(self, &maxFontSizeKey) floatValue];
}

- (void)setMinFontSize:(CGFloat)minFontSize {
    objc_setAssociatedObject(self, &minFontSizeKey, [NSNumber numberWithFloat:minFontSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)minFontSize {
    return [objc_getAssociatedObject(self, &minFontSizeKey) floatValue];
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer {
    if (!self.isZoomEnabled) return;
    CGFloat pointSize = (gestureRecognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;
    pointSize         = MAX(MIN(pointSize, self.maxFontSize), self.minFontSize);
    self.font         = [UIFont fontWithName:self.font.fontName size:pointSize];
}

- (void)setZoomEnabled:(BOOL)zoomEnabled {
    objc_setAssociatedObject(self, &zoomEnabledKey, [NSNumber numberWithBool:zoomEnabled], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) // initialized already
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) return;
        self.minFontSize                          = self.minFontSize ?: 8.0f;
        self.maxFontSize                          = self.maxFontSize ?: 42.0f;
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
    }
}

- (BOOL)isZoomEnabled {
    return [objc_getAssociatedObject(self, &zoomEnabledKey) boolValue];
}

@end
