//
//  NSObject+DNAppInfo.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DNAppInfo)

/**
 *  发布版本号
 */
- (NSString *)getVersion;
/**
 *  内部版本号
 */
- (NSInteger)getBuild;
/**
 *  ID标识符
 */
- (NSString *)getIdentifier;
/**
 *  当前语言
 */
- (NSString *)getCurrentLanguage;
/**
 *  设备型号
 */
- (NSString *)getDeviceModel;

@end
