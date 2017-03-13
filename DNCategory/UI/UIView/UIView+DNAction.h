//
//  UIView+DNAction.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (DNAction)

/**
 *  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(GestureActionBlock)block;
/**
 *  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;

/**
 *  添加侧滑手势
 *
 *  @param direction 侧滑方向
 *  @param block     代码块
 */
- (void)addSwipeWithDirection:(UISwipeGestureRecognizerDirection)direction Block:(GestureActionBlock)block;

/**
 *  拖拽手势
 */
- (void)panGestureAnimationAction:(dispatch_block_t) gestureAction andEndGestureAction:(dispatch_block_t) endGestureAction;

/**
 *  随意拖拽
 */
- (void)dragCasual;

/**
 *  捏合手势
 */
- (void)pinGestureAnimationAction:(dispatch_block_t) gestureAction andEndGestureAction:(dispatch_block_t) endGestureAction;

/**
 *  随意缩放
 */
- (void)pinCasuale;

/**
 *  旋转手势
 */

- (void)rotationGestureAnimationAction:(dispatch_block_t) gestureAction andEndGestureAction:(dispatch_block_t) endGestureAction;
/**
 *  随意旋转
 */

-(void)rotationCasuale;

/**
 *  移除所有手势
 */
-(void)removeGestureRecognizers;

@end
