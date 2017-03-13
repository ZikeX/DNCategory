//
//  UIView+DNAnimation.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    DNAnimationShakeViewDirectionX,
    DNAnimationShakeViewDirectionY,
    DNAnimationShakeViewDirectionXYLeft,
    DNAnimationShakeViewDirectionXYRight
}DNAnimationShakeViewDirection;

@interface UIView (DNAnimation)

/**
 *  添加运动效果（类似home页的壁纸效果）
 *
 *  @param minRel     最小位移
 *  @param maxRel     最大位移
 *  @param effectType 位移方向（水平，垂直）
 *  @param keyPath    位移坐标（"center.x"，"center.y"）
 */
- (void)addMotionEffectWithMinRelative:(float)minRel maxRelative:(float)maxRel EffectType:(UIInterpolatingMotionEffectType)effectType keyPath:(NSString *)keyPath;

/**
 *  从底部升起出现
 */
- (void)showFromBottom;

/**
 *  消失降到底部
 */
- (void)dismissToBottomWithCompleteBlock:(void(^)())completeBlock;

/**
 *  从透明到不透明
 */
- (void)emerge;

/**
 *  从不透明到透明
 */
- (void)fake;

/**
 *  按钮震动动画
 */
- (void)startSelectedAnimation;

/**
 *  脉冲动画
 */
- (void)pulseViewWithDurationTime:(CGFloat)seconds;

/**
 *  摇摆动画line
 */
- (void)shakeViewLine;

/**
 *  可以拖动
 */
- (void)makeDraggable;

/**
 *  删除移动
 */
- (void)removeDraggable;

/**
 *  摆动动画line
 *
 *  @param distance    摆动距离
 *  @param time        每次持续时间
 *  @param repeatCount 重复次数
 *  @param direction   摆动方向
 */
- (void)shakeViewDistace:(CGFloat)distance andDuration:(NSTimeInterval)time andRepeateCount:(NSInteger)repeatCount andDirection:(DNAnimationShakeViewDirection)direction;

/**
 *  抖动动画
 */
- (void)shakeViewRotation;

/**
 *  抖动动画
 *
 *  @param angel       弧度
 *  @param time        每次持续时间
 *  @param repeatCount 重复次数
 *  @param save        执行完是否删除动画
 */
- (void)shakeViewWithAngel:(CGFloat)angel andDuration:(NSTimeInterval)time andRepeatCount:(NSInteger)repeatCount andSave:(BOOL)save;

/**
 *  移动位置
 *
 *  @param time    持续时间
 *  @param x       x
 *  @param y       y
 *  @param restore 移动完成是否还原位置
 *  @param complate 完成之后回调
 */
- (void)translationAnimationWithDuration:(NSTimeInterval)time changeX:(CGFloat)x changeY:(CGFloat)y isRestore:(BOOL)restore complate:(void (^)())complate;




@end
