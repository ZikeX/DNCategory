//
//  UIWebView+DNJavaScriptAlert.h
//  ReadingGroup
//
//  Created by mainone on 16/8/1.
//  Copyright © 2016年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (DNJavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;

@end
