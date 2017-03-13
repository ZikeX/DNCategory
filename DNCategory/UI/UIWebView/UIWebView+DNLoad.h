//
//  UIWebView+DNLoad.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (DNLoad)

/**
 *  清空cookie
 */
- (void)clearCookies;
+ (void)clearCookies;

/**
 *  加载网站
 *
 *  @param website 网址
 */
- (void)loadWebsite:(NSString *)website;

/**
 *  post加载网站
 *
 *  @param website 网址
 *  @param body    参数
 */
- (void)postWebsite:(NSString *)website body:(NSString *)body;

/**
 *  加载本地网页
 *
 *  @param htmlName 文件名 xxx.html
 */
- (void)loadLocalHTML:(NSString *)htmlName;

@end
