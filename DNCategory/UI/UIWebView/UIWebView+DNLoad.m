//
//  UIWebView+DNLoad.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIWebView+DNLoad.h"

@implementation UIWebView (DNLoad)

- (void)clearCookies {
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+ (void)clearCookies {
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)loadWebsite:(NSString *)website {
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:website]]];
}

- (void)postWebsite:(NSString *)website body:(NSString *)body {
    NSURL *url = [NSURL URLWithString:website];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [self loadRequest:request];
}

- (void)loadLocalHTML:(NSString*)htmlName {
    NSString *filePath    = [[NSBundle mainBundle] pathForResource:htmlName ofType:nil];
    NSURL *url            = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

@end
