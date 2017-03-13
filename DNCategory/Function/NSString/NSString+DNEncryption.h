//
//  NSString+DNEncryption.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DNEncryption)

/**
 *  AES加密
 */
- (NSString*)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  AES解密
 */
- (NSString*)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  3DES加密
 */
- (NSString*)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  3DES解密
 */
- (NSString*)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  md5加密
 */
- (NSString *)MD5String;

@end
