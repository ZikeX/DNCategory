//
//  UIView+DNAnimation.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIView+DNAnimation.h"
#import <objc/runtime.h>

#define SCREEN_H    ([[UIScreen mainScreen] bounds].size.height)
#define BottomRect CGRectMake(self.frame.origin.x, SCREEN_H, self.frame.size.width, self.frame.size.height)

#define ANGLE_TO_RADIAN(angle) ((angle)/180.0 * M_PI)


@implementation UIView (DNAnimation)

- (void)addMotionEffectWithMinRelative:(float)minRel maxRelative:(float)maxRel EffectType:(UIInterpolatingMotionEffectType)effectType keyPath:(NSString *)keyPath {
    UIInterpolatingMotionEffect * xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:keyPath type:effectType];
    xEffect.minimumRelativeValue =  [NSNumber numberWithFloat:minRel];
    xEffect.maximumRelativeValue = [NSNumber numberWithFloat:maxRel];
    [self addMotionEffect:xEffect];
}


#pragma mark - 底部出现动画
- (void)showFromBottom {
    CGRect rect = self.frame;
    self.frame = BottomRect;
    [self executeAnimationWithFrame:rect completeBlock:nil];
}

#pragma mark - 底部消失动画
- (void)dismissToBottomWithCompleteBlock:(void(^)())completeBlock {
    [self executeAnimationWithFrame:BottomRect completeBlock:completeBlock];
}

#pragma mark - 背景浮现动画
- (void)emerge {
    self.alpha = 0.0;
    [self executeAnimationWithAlpha:0.2 completeBlock:nil];
}

#pragma mark - 背景淡去动画
- (void)fake {
    [self executeAnimationWithAlpha:0.f completeBlock:nil];
}

#pragma mark - 执行动画
- (void)executeAnimationWithAlpha:(CGFloat)alpha completeBlock:(void(^)())completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = alpha;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

- (void)executeAnimationWithFrame:(CGRect)rect completeBlock:(void(^)())completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

#pragma mark - 按钮震动动画
- (void)startSelectedAnimation {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    ani.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 0.4;
    [self.layer addAnimation:ani forKey:@"transformAni"];
}

/* 脉冲动画 */
- (void)pulseViewWithDurationTime:(CGFloat)seconds {
    [self pulseViewWithDuration:seconds];
}

- (void)pulseViewWithDuration:(CGFloat)duration {
    [UIView animateWithDuration:duration / 6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:duration / 6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            } completion:^(BOOL finished) {
                if(finished)
                {
                    [UIView animateWithDuration:duration / 6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    } completion:^(BOOL finished) {
                        if(finished)
                        {
                            [UIView animateWithDuration:duration / 6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            } completion:^(BOOL finished) {
                                if(finished)
                                {
                                    [UIView animateWithDuration:duration / 6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    } completion:^(BOOL finished) {
                                        if(finished)
                                        {
                                            [UIView animateWithDuration:duration / 6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            } completion:nil];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}


/*摇摆动画 */
- (void)shakeViewLine {
    [self shakeViewDistace:3.0f andDuration:0.07f andRepeateCount:2.0f andDirection:DNAnimationShakeViewDirectionX];
}

- (void)makeDraggable {
    [self makeDraggableInView:self.superview damping:0.4];
}

- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping {
    if (!view) return;
    [self removeDraggable];
    
    self.dn_playground = view;
    self.dn_damping = damping;
    
    [self dn_creatAnimator];
    [self dn_addPanGesture];
}

- (void)removeDraggable {
    [self removeGestureRecognizer:self.dn_panGesture];
    self.dn_panGesture = nil;
    self.dn_playground = nil;
    self.dn_animator = nil;
    self.dn_snapBehavior = nil;
    self.dn_attachmentBehavior = nil;
    self.dn_centerPoint = CGPointZero;
}

- (void)dn_creatAnimator {
    self.dn_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.dn_playground];
    [self updateSnapPoint];
}

- (void)dn_addPanGesture {
    self.dn_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dn_panGesture:)];
    [self addGestureRecognizer:self.dn_panGesture];
}

- (void)updateSnapPoint {
    self.dn_centerPoint = [self convertPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) toView:self.dn_playground];
    self.dn_snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.dn_centerPoint];
    self.dn_snapBehavior.damping = self.dn_damping;
}

- (void)dn_panGesture:(UIPanGestureRecognizer *)pan {
    CGPoint panLocation = [pan locationInView:self.dn_playground];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        UIOffset offset = UIOffsetMake(panLocation.x - self.dn_centerPoint.x, panLocation.y - self.dn_centerPoint.y);
        [self.dn_animator removeAllBehaviors];
        self.dn_attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self
                                                               offsetFromCenter:offset
                                                               attachedToAnchor:panLocation];
        [self.dn_animator addBehavior:self.dn_attachmentBehavior];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.dn_attachmentBehavior setAnchorPoint:panLocation];
    } else if (pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled ||
             pan.state == UIGestureRecognizerStateFailed) {
        [self.dn_animator addBehavior:self.dn_snapBehavior];
        [self.dn_animator removeBehavior:self.dn_attachmentBehavior];
    }
}


- (void)shakeViewDistace:(CGFloat)distance andDuration:(NSTimeInterval)time andRepeateCount:(NSInteger)repeatCount andDirection:(DNAnimationShakeViewDirection)direction {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    anim.duration = time;
    anim.repeatCount = repeatCount;
    anim.autoreverses = YES;
    
    if (direction==DNAnimationShakeViewDirectionX) {
        anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-distance, 0.0f, 0.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(distance, 0.0f, 0.0f)]];
    } else if (direction==DNAnimationShakeViewDirectionY) {
        anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, -distance, 0.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, distance, 0.0f)]];
    } else if (direction==DNAnimationShakeViewDirectionXYLeft) {
        anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-distance, -distance, 0.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(distance, distance, 0.0f)]];
    } else if (direction==DNAnimationShakeViewDirectionXYRight) {
        anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(distance, -distance, 0.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-distance, distance, 0.0f)]];
    }
    [self.layer addAnimation:anim forKey:@"ShakeLine"];
}

- (void)shakeViewRotation {
    [self shakeViewWithAngel:5.0 andDuration:.2 andRepeatCount:10 andSave:YES];
}

- (void)shakeViewWithAngel:(CGFloat)angel andDuration:(NSTimeInterval)time andRepeatCount:(NSInteger)repeatCount andSave:(BOOL)save {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.duration = time;
    anim.repeatCount = repeatCount;
    anim.values = @[@(ANGLE_TO_RADIAN(-angel)), @(ANGLE_TO_RADIAN(angel)), @(ANGLE_TO_RADIAN(-angel))];
    if (save) {
        anim.removedOnCompletion=NO;
        anim.fillMode=kCAFillModeRemoved;
    }
    [self.layer addAnimation:anim forKey:@"shakeAngel"];
}

- (void)translationAnimationWithDuration:(NSTimeInterval)time changeX:(CGFloat)x changeY:(CGFloat)y isRestore:(BOOL)restore complate:(void (^)())complate {
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformMakeTranslation(x, y);
    } completion:^(BOOL finished) {
        if (restore) {
            self.transform = CGAffineTransformIdentity;
        }
        complate();
    }];
}

#pragma mark - Associated Object

- (void)setDn_playground:(id)object {
    objc_setAssociatedObject(self, @selector(dn_playground), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)dn_playground {
    return objc_getAssociatedObject(self, @selector(dn_playground));
}

- (void)setDn_animator:(id)object {
    objc_setAssociatedObject(self, @selector(dn_animator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDynamicAnimator *)dn_animator {
    return objc_getAssociatedObject(self, @selector(dn_animator));
}

- (void)setDn_snapBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(dn_snapBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UISnapBehavior *)dn_snapBehavior {
    return objc_getAssociatedObject(self, @selector(dn_snapBehavior));
}

- (void)setDn_attachmentBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(dn_attachmentBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIAttachmentBehavior *)dn_attachmentBehavior {
    return objc_getAssociatedObject(self, @selector(dn_attachmentBehavior));
}

- (void)setDn_panGesture:(id)object {
    objc_setAssociatedObject(self, @selector(dn_panGesture), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIPanGestureRecognizer *)dn_panGesture {
    return objc_getAssociatedObject(self, @selector(dn_panGesture));
}

- (void)setDn_centerPoint:(CGPoint)point {
    objc_setAssociatedObject(self, @selector(dn_centerPoint), [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)dn_centerPoint {
    return [objc_getAssociatedObject(self, @selector(dn_centerPoint)) CGPointValue];
}

- (void)setDn_damping:(CGFloat)damping {
    objc_setAssociatedObject(self, @selector(dn_damping), @(damping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)dn_damping {
    return [objc_getAssociatedObject(self, @selector(dn_damping)) floatValue];
}

@end
