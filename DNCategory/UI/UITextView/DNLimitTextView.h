//
//  DNLimitTextView.h
//  DNCommunity
//
//  Created by apple on 17/2/20.
//  Copyright © 2017年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DNLimitTextView;

@protocol DNLimitTextViewDelegate <NSObject>
@optional
-(void)textViewReturnKeyPress:(DNLimitTextView *)textView;
-(void)lwTextViewDidChange:(DNLimitTextView *)textView;
@end


typedef void(^FSTextViewHandler)(DNLimitTextView *textView);

IB_DESIGNABLE

@interface DNLimitTextView : UITextView

typedef NS_ENUM(NSInteger,LimitTextType)
{
    //截取字符串
    InterceptionStringTextView = 0,
    //无法输入
    UnablToEnterTextView = 1
};

@property(nonatomic,weak)id<DNLimitTextViewDelegate>returnDelegate;

/*! @brief 便利构造器创建FSTextView实例.
 */
+ (instancetype)textView;

/*! @brief 设定文本改变Block回调. (切记弱化引用, 以免造成内存泄露.)
 */
- (void)addTextDidChangeHandler:(FSTextViewHandler)eventHandler;

/*! @brief 设定达到最大长度Block回调. (切记弱化引用, 以免造成内存泄露.)
 */
- (void)addTextLengthDidMaxHandler:(FSTextViewHandler)maxHandler;

@property (nonatomic, assign) IBInspectable NSUInteger maxLength; ///< 最大限制文本长度, 默认为无穷大(即不限制).

//可输入字数
@property (nonatomic,assign) NSInteger canEnterWordsNumber;

@property (assign , nonatomic) BOOL isEmoticons;     // default is NO 是否筛除emoji表情
@property (nonatomic, assign) IBInspectable CGFloat   cornerRadius; ///< 圆角半径.
@property (nonatomic, assign) IBInspectable CGFloat   borderWidth; ///< 边框宽度.
@property (nonatomic, strong) IBInspectable UIColor  *borderColor; ///< 边框颜色.

@property (nonatomic, copy)   IBInspectable NSString *placeholder; ///< placeholder, 会自适应TextView宽高以及横竖屏切换, 字体默认和TextView一致.
@property (nonatomic, strong) IBInspectable UIColor  *placeholderColor; ///< placeholder文本颜色, 默认为#C7C7CD.
@property (nonatomic, strong) UIFont *placeholderFont; ///< placeholder文本字体, 默认为UITextView的默认字体.

//长度限制样式
@property(nonatomic,assign)LimitTextType limiType;// default is 0

@end
