//
//  NSData+DNEncryption.m
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSData+DNEncryption.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (DNEncryption)


- (NSData *)encryptedAESWithKey:(NSString *)key andIV:(NSData *)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    CCCryptorStatus status = CCCrypt(kCCEncrypt,kCCAlgorithmAES128,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,encryptedData.mutableBytes,encryptedData.length,&dataMoved);
    if (status == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    return nil;
}

- (NSData *)decryptedAESWithKey:(NSString *)key andIV:(NSData *)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    CCCryptorStatus result = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding, keyData.bytes, keyData.length,iv.bytes,self.bytes,self.length,decryptedData.mutableBytes, decryptedData.length,&dataMoved);
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

- (NSData *)encrypted3DESWithKey:(NSString *)key andIV:(NSData *)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    CCCryptorStatus result = CCCrypt(kCCEncrypt,kCCAlgorithm3DES,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,encryptedData.mutableBytes,encryptedData.length,&dataMoved);
    if (result == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    return nil;
}

- (NSData *)decrypted3DESWithKey:(NSString *)key andIV:(NSData *)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    CCCryptorStatus result = CCCrypt(kCCDecrypt,kCCAlgorithm3DES,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,decryptedData.mutableBytes,decryptedData.length,&dataMoved);
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

@end
