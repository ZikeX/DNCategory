//
//  UIButton+DNAction.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIButton+DNAction.h"
#import <objc/runtime.h>

static const void *UIButtonBlockKey = &UIButtonBlockKey;
static NSString *const kIndicatorViewKey = @"indicatorView";
static NSString *const kButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (DNAction)

- (void)addActionHandler:(TouchedBlock)touchHandler {
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionTouched:(UIButton *)btn {
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}

- (void)beginSubmitting:(NSString *)title {
    [self endSubmitting];
    
    self.submitting = @YES;
    self.hidden = YES;
    
    self.modalView = [[UIView alloc] initWithFrame:self.frame];
    self.modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.modalView.layer.borderWidth = self.layer.borderWidth;
    self.modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.modalView.bounds;
    self.spinnerView = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.spinnerView.bounds;
    self.spinnerView.frame = CGRectMake(
                                        15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                        spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.spinnerTitleLabel.text = title;
    self.spinnerTitleLabel.font = self.titleLabel.font;
    self.spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.modalView addSubview:self.spinnerView];
    [self.modalView addSubview:self.spinnerTitleLabel];
    [self.superview addSubview:self.modalView];
    [self.spinnerView startAnimating];
}

- (void)endSubmitting {
    if (!self.isSubmitting.boolValue) {
        return;
    }
    
    self.submitting = @NO;
    self.hidden = NO;
    
    [self.modalView removeFromSuperview];
    self.modalView = nil;
    self.spinnerView = nil;
    self.spinnerTitleLabel = nil;
}

- (NSNumber *)isSubmitting {
    return objc_getAssociatedObject(self, @selector(setSubmitting:));
}

- (void)setSubmitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setSubmitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)spinnerView {
    return objc_getAssociatedObject(self, @selector(setSpinnerView:));
}

- (void)setSpinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setSpinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)modalView {
    return objc_getAssociatedObject(self, @selector(setModalView:));
    
}

- (void)setModalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setModalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setSpinnerTitleLabel:));
}

- (void)setSpinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setSpinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)touchAreaInsets {
    return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}

- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}


@end
