//
//  UIViewController+DNTopBarMessage.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kDXTopBarBackgroundColor;
extern NSString * const kDXTopBarTextColor;
extern NSString * const kDXTopBarTextFont;
extern NSString * const kDXTopBarIcon;


///通知显示的2种模式
typedef enum {
    TopBarMessageModeOverlay = 0,   //视图不下移
    TopBarMessageModeResize,        //视图下移
    
}TopBarMessageMode;

@interface TopWarningView : UIView

@property (nonatomic, strong) NSString *warningText;
@property (nonatomic, strong) UIImageView *iconIgv;
@property (nonatomic, copy) dispatch_block_t tapHandler;
@property (nonatomic, assign) float dimissDelay;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, assign) TopBarMessageMode mode;

- (void)resetViews;
- (void)dismiss;

@end

@interface UIViewController (DNTopBarMessage)

//@{kDXTopBarBackgroundColor:[UIColor blueColor], kDXTopBarTextColor : [UIColor yellowColor], kDXTopBarIcon : [UIImage imageNamed:@"icon.png"], kDXTopBarTextFont : [UIFont boldSystemFontOfSize:15.0]}
+ (void)setTopMessageDefaultApperance:(NSDictionary *)apperance;

- (void)showTopMessage:(NSString *)message topBarConfig:(NSDictionary *)config mode:(TopBarMessageMode)messageMode dismissDelay:(float)delay withTapBlock:(dispatch_block_t)tapHandler;

- (void)showTopMessage:(NSString *)message;

/**
 *  隐藏弹出视图
 */
- (void)dismissTopMessage;

@end
