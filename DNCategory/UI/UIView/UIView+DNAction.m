//
//  UIView+DNAction.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIView+DNAction.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic ,copy)dispatch_block_t gestureAction;
@property (nonatomic ,copy)dispatch_block_t endGestureAction;

@end

@implementation UIView (DNAction)


static char gestureActionKey;
static char endGestureActionKey;

-(void)setGestureAction:(dispatch_block_t)gestureAction {
    objc_setAssociatedObject(self, &gestureActionKey, gestureAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(dispatch_block_t)gestureAction {
    return objc_getAssociatedObject(self, &gestureActionKey);
}

-(void)setEndGestureAction:(dispatch_block_t)endGestureAction {
    objc_setAssociatedObject(self, &endGestureActionKey, endGestureAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(dispatch_block_t)endGestureAction {
    return objc_getAssociatedObject(self, &endGestureActionKey);
}

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;
static char kActionHandlerSwipeBlockKey;
static char kActionHandlerSwipeGestureKey;

- (void)addTapActionWithBlock:(GestureActionBlock)block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)addLongPressActionWithBlock:(GestureActionBlock)block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)addSwipeWithDirection:(UISwipeGestureRecognizerDirection)direction Block:(GestureActionBlock)block {
    UISwipeGestureRecognizer * gesture = objc_getAssociatedObject(self, &kActionHandlerSwipeGestureKey);
    gesture.direction = direction;
    if (!gesture) {
        gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForSwipeGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerSwipeGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerSwipeBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForSwipeGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerSwipeBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)panGestureAnimationAction:(dispatch_block_t) gestureAction andEndGestureAction:(dispatch_block_t) endGestureAction {
    self.gestureAction = gestureAction;
    self.endGestureAction = endGestureAction;
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
}

- (void)dragCasual {
    [self panGestureAnimationAction:nil andEndGestureAction:nil];
}

- (void)panAction:(UIPanGestureRecognizer*)pan {
    __weak typeof(self) weakSelf = self;
    [self gesture:pan andDefaultGestureAcion:^{
        CGPoint point=[pan translationInView:weakSelf];
        weakSelf.transform = CGAffineTransformTranslate(weakSelf.transform, point.x, point.y);
        [pan setTranslation:CGPointZero inView:weakSelf];
    }];
}

- (void)pinGestureAnimationAction:(dispatch_block_t) gestureAction andEndGestureAction:(dispatch_block_t) endGestureAction {
    self.gestureAction = gestureAction;
    self.endGestureAction = endGestureAction;
    UIPinchGestureRecognizer* pin=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinAction:)];
    [self addGestureRecognizer:pin];
}

- (void)pinCasuale {
    [self pinGestureAnimationAction:nil andEndGestureAction:nil];
}

- (void)pinAction:(UIPinchGestureRecognizer*)pin {
    __weak typeof(self) weakSelf = self;
    [self gesture:pin andDefaultGestureAcion:^{
        weakSelf.transform=CGAffineTransformScale(weakSelf.transform, pin.scale, pin.scale);
        pin.scale=1;
    }];
}

- (void)rotationGestureAnimationAction:(dispatch_block_t) gestureAction andEndGestureAction:(dispatch_block_t) endGestureAction {
    self.gestureAction = gestureAction;
    self.endGestureAction = endGestureAction;
    UIRotationGestureRecognizer* rotation=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
    [self addGestureRecognizer:rotation];
}

- (void)rotationCasuale {
    [self rotationGestureAnimationAction:nil andEndGestureAction:nil];
}

- (void)rotationAction:(UIRotationGestureRecognizer*)rotation {
    __weak typeof(self) weakSelf = self;
    [self gesture:rotation andDefaultGestureAcion:^{
        weakSelf.transform=CGAffineTransformRotate(weakSelf.transform, rotation.rotation);
    }];
}

- (void)gesture:(UIGestureRecognizer*)gesture andDefaultGestureAcion:(dispatch_block_t)defaultGestureAction {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.endGestureAction) {
            self.endGestureAction();
        }
    } else {
        if (self.gestureAction) {
            self.gestureAction();
        } else {
            if (defaultGestureAction) defaultGestureAction();
        }
    }
}

- (void)removeGestureRecognizers{
    if (self.gestureRecognizers.count == 0)return;
    while (self.gestureRecognizers.count != 0) {
        UITapGestureRecognizer * tap = [self.gestureRecognizers objectAtIndex:0];
        [self removeGestureRecognizer:tap];
    }
}

@end
