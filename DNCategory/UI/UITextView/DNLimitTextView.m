//
//  DNLimitTextView.m
//  DNCommunity
//
//  Created by apple on 17/2/20.
//  Copyright © 2017年 mainone. All rights reserved.
//

#import "DNLimitTextView.h"

CGFloat const kFSTextViewPlaceholderVerticalMargin = 8.0; ///< placeholder垂直方向边距
CGFloat const kFSTextViewPlaceholderHorizontalMargin = 6.0; ///< placeholder水平方向边距

@interface DNLimitTextView ()<UITextViewDelegate>

@property (nonatomic, copy) FSTextViewHandler changeHandler; ///< 文本改变Block
@property (nonatomic, copy) FSTextViewHandler maxHandler; ///< 达到最大限制字符数Block
@property (nonatomic, weak) UILabel *placeholderLabel; ///< placeholderLabel


@property (copy , nonatomic) NSString * lastString;

@end

@implementation DNLimitTextView

#pragma mark - Super Methods

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        [self layoutIfNeeded];
    }
    [self initialize];
}

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self initialize];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _changeHandler = NULL;
    _maxHandler = NULL;
}

#pragma mark - Private

- (void)initialize {
    // 监听文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.delegate = self;
    // 基本配置 (需判断是否在Storyboard中设置了值)
    if (_maxLength == 0 || _maxLength == NSNotFound) _maxLength = NSUIntegerMax;
    if (!_placeholderColor) _placeholderColor = [UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000];
    
    // 基本设定 (需判断是否在Storyboard中设置了值)
    if (!self.backgroundColor) self.backgroundColor = [UIColor whiteColor];
    if (!self.font) self.font = [UIFont systemFontOfSize:15.f];
    
    // placeholderLabel
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.font = self.font;
    placeholderLabel.text = _placeholder ? : @""; // 可能在Storyboard中设置了Placeholder
    placeholderLabel.textColor = _placeholderColor;
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:placeholderLabel];
    _placeholderLabel = placeholderLabel;
    
    // constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:kFSTextViewPlaceholderVerticalMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:kFSTextViewPlaceholderHorizontalMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-kFSTextViewPlaceholderHorizontalMargin*2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:-kFSTextViewPlaceholderVerticalMargin*2]];
}


#pragma mark - Getter
// SuperGetter
- (NSString *)text {
    NSString *currentText = [super text];
    return [currentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; // 去除首尾的空格和换行.
}

#pragma mark - Setter
// SuperStter
- (void)setText:(NSString *)text {
    [super setText:text];
    _placeholderLabel.hidden = [@(text.length) boolValue];
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderLabel.font = font;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}
- (void)setBorderColor:(UIColor *)borderColor {
    if (!borderColor) return;
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (!placeholder) return;
    _placeholder = [placeholder copy];
    if (_placeholder.length > 0) {
        _placeholderLabel.text = _placeholder;
    }
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (!placeholderColor) return;
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = _placeholderColor;
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    if (!placeholderFont) return;
    _placeholderFont = placeholderFont;
    _placeholderLabel.font = _placeholderFont;
}

#pragma mark - NSNotification
- (void)textDidChange:(NSNotification *)notification {
    // 根据字符数量显示或者隐藏placeholderLabel
    _placeholderLabel.hidden = [@(self.text.length) boolValue];
    
    // 禁止第一个字符输入空格或者换行
    if (self.text.length == 1) {
        if ([self.text isEqualToString:@" "] || [self.text isEqualToString:@"\n"]) {
            self.text = @"";
        }
    }
    
    if (_maxLength != NSUIntegerMax && _maxLength != 0) { // 只有当maxLength字段的值不为无穷大整型也不为0时才计算限制字符数.
        NSString    *toBeString    = self.text;
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position   = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > _maxLength) {
                self.text = [toBeString substringToIndex:_maxLength]; // 截取最大限制字符数.
                _maxHandler?_maxHandler(self):NULL; // 回调达到最大限制的Block.
            }
        }
    }
    
    // 回调文本改变的Block.
    _changeHandler?_changeHandler(self):NULL;
}

- (void)textChanged:(NSNotification *)notification
{
    if (!notification) {
        return;
    }
    
    if (self.text.length != 0) {
        [self setNeedsDisplay];
    }
    if (self.maxLength > 0) {
        NSString *toBeString = self.text;
        NSString *lang = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];//键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) {//简体中文输入,包括简体拼音,简体五笔,简体手写
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            //没有高亮选择的字,则对已输入的文字进行数字统计和限制
            if (!position) {
                if (!self.isEmoticons) {
                    [self setDeleteEmojiText];
                }
                if (toBeString.length > self.maxLength) {
                    switch (self.limiType) {
                        case 0:
                            self.text = [self.text substringToIndex:self.maxLength];
                            break;

                        case 1:
                            [self setLastText];
                            
                            break;
                        default:
                            break;
                    }
                }
                self.lastString = self.text;
            }
            //有高亮选择的字符串,则暂不对文字进行统计和限制
            else{
                return;
            }
        }
        //中文输入法以外的直接对其统计限制即可,不考虑其他语种情况
        else{
            if (!self.isEmoticons) {
                [self setDeleteEmojiText];
            }
            if (toBeString.length > self.maxLength) {
                switch (self.limiType) {
                    case 0:
                        self.text = [self.text substringToIndex:self.maxLength];
                        break;
                        case 1:
                        [self setLastText];
                        break;
                    default:
                        break;
                }
            }
            self.lastString = self.text;
        }
    }
    
    _canEnterWordsNumber = self.text.length;
    _canEnterWordsNumber = _canEnterWordsNumber > 0 ? _canEnterWordsNumber:0;
    if (self.returnDelegate && [self.returnDelegate respondsToSelector:@selector(lwTextViewDidChange:)]) {
        [self.returnDelegate lwTextViewDidChange:self];
    }
}

-(void)setDeleteEmojiText{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange range;
    if([[self deleteEmojiWithString:self.text] length]<self.text.length){
        range = NSMakeRange(location-(self.text.length-self.lastString.length), length);
    }else{
        range = NSMakeRange(location, length);
    }
    [self setText:[self deleteEmojiWithString:self.text]];
    beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


-(void)setLastText{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange range = NSMakeRange(location-(self.text.length-self.lastString.length), length);
    self.text = self.lastString;
    beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


//筛除emoji表情
-(NSString *)deleteEmojiWithString:(NSString *)string{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString * text = [regex stringByReplacingMatchesInString:string
                                                      options:0
                                                        range:NSMakeRange(0, [self.text length])
                                                 withTemplate:@""];
    return text;
}

#pragma mark - Public

/*! @brief 便利构造器创建FSTextView实例.
 */
+ (instancetype)textView {
    return [[self alloc] init];
}

/*! @brief 设定文本改变Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextDidChangeHandler:(FSTextViewHandler)changeHandler{
    _changeHandler = [changeHandler copy];
}

/*! @brief 设定达到最大长度Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextLengthDidMaxHandler:(FSTextViewHandler)maxHandler {
    _maxHandler = [maxHandler copy];
}

#pragma mark UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (self.returnDelegate&&[self.returnDelegate respondsToSelector:@selector(textViewReturnKeyPress:)]) {
            [self.returnDelegate textViewReturnKeyPress:self];
        }
        return NO;
    }
    return YES;
}

@end
