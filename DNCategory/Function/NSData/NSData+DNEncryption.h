//
//  NSData+DNEncryption.h
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DNEncryption)

/**
 *  AES加密
 */
- (NSData *)encryptedAESWithKey:(NSString *)key andIV:(NSData *)iv;

/**
 *  AES解密
 */
- (NSData *)decryptedAESWithKey:(NSString *)key andIV:(NSData *)iv;

/**
 *  3DES加密
 */
- (NSData *)encrypted3DESWithKey:(NSString *)key andIV:(NSData *)iv;

/**
 *  3DES解密
 */
- (NSData *)decrypted3DESWithKey:(NSString *)key andIV:(NSData *)iv;

@end
