//
//  DNTextField.h
//  DNCommunity
//
//  Created by apple on 17/2/11.
//  Copyright © 2017年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNTextField;
@protocol DNTextFieldDelegate <NSObject>
@optional
-(void)textFieldReturnKeyPress:(DNTextField *)textField;
@end

@interface DNTextField : UITextField

typedef NS_ENUM(NSInteger,LimitType)
{
    //截取字符串
    InterceptionString = 0,
    //无法输入
    UnbleToEnter = 1
};


//textField能够输入的最大字符串长度
@property(nonatomic,assign)NSInteger MaxWordNumber;
//长度限制样式
@property(nonatomic,assign)LimitType LimiType;        // default is 0
//是否筛除emoji表情
@property(nonatomic,assign)BOOL isEoticons;         // default is NO
//textfield输入内容的起始坐标
@property(nonatomic)CGPoint textPoint;             // default is (8,8)
//可输入字数
@property(nonatomic,assign)NSInteger canEnterWordsNumber;
@property(nonatomic,weak)id<DNTextFieldDelegate>returnDelegate;

//获取光标位置
- (NSRange) selectedRange;
//设置光标位置
- (void) setSelectedRange:(NSRange) range;

@end
