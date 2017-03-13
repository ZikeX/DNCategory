//
//  UIButton+DNAction.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (DNAction)

/**
 *  button添加点击事件
 *
 *  @param touchHandler tag是button的tag值
 */
-(void)addActionHandler:(TouchedBlock)touchHandler;

/**
 *  按钮点击后禁用按钮并在按钮上显示 指示器和文字
 *
 *  @param title 显示的文字
 */
- (void)beginSubmitting:(NSString *)title;

/**
 *  恢复点击前的状态
 */
- (void)endSubmitting;

/**
 *  按钮是否在提交中
 */
@property(nonatomic, readonly, getter=isSubmitting) NSNumber *submitting;

/**
 *  设置button额外点击有效区域
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;


@end
