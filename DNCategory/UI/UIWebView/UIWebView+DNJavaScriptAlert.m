//
//  UIWebView+DNJavaScriptAlert.m
//  ReadingGroup
//
//  Created by mainone on 16/8/1.
//  Copyright © 2016年 mainone. All rights reserved.
//

#import "UIWebView+DNJavaScriptAlert.h"


@implementation UIWebView (DNJavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame {
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [customAlert show];
}


@end
