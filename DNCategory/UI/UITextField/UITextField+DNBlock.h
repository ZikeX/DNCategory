//
//  UITextField+DNBlock.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (DNBlock)

@property (copy, nonatomic) BOOL (^shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^shouldClearBlock)(UITextField *textField);

- (void)setShouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;/**<即将开始编辑*/
- (void)setShouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;/**<即将结束编辑*/
- (void)setDidBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;/**<已经开始编辑*/
- (void)setDidEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;/**<已经结束编辑*/
- (void)setShouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;/**<输入文字变化*/
- (void)setShouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;/**<清除*/
- (void)setShouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;/**<return按键操作*/

@end
