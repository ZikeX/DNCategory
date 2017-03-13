//
//  NSString+DNChange.m
//  DNCategory
//
//  Created by mainone on 16/5/31.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSString+DNChange.h"
#import "NSData+DNChange.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#define ASSOCIATIVE_CURRENT_DICTIONARY_KEY @"ASSOCIATIVE_CURRENT_DICTIONARY_KEY"
#define ASSOCIATIVE_CURRENT_TEXT_KEY @"ASSOCIATIVE_CURRENT_TEXT_KEY"

@interface NSString () <NSXMLParserDelegate>

@property(nonatomic, retain)NSMutableArray *currentDictionaries;
@property(nonatomic, retain)NSMutableString *currentText;

@end

@implementation NSString (DNChange)

- (NSString *)utf8String {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSDictionary *)dictionaryValue {
    NSError *errorJson;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
    if (errorJson != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, errorJson);
#endif
    }
    return jsonDict;
}

- (NSString *)base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString {
    return [NSString stringWithBase64EncodedString:self];
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)string {
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data) {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSData *)base64DecodedData {
    return [NSData dataWithBase64EncodedString:self];
}

- (NSString *)makeUnicodeToString {
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (NSDictionary *)dictionaryFromXML {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    self.currentDictionaries = [[NSMutableArray alloc] init] ;
    self.currentText = [[NSMutableString alloc] init];
    [self.currentDictionaries addObject:[NSMutableDictionary dictionary]];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];
    if(success)
        return [self.currentDictionaries objectAtIndex:0];
    else
        return nil;
}

- (void)setCurrentDictionaries:(NSMutableArray *)currentDictionaries {
    objc_setAssociatedObject(self, ASSOCIATIVE_CURRENT_DICTIONARY_KEY, currentDictionaries, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)currentDictionaries {
    return objc_getAssociatedObject(self, ASSOCIATIVE_CURRENT_DICTIONARY_KEY);
}

- (void)setCurrentText:(NSMutableString *)currentText {
    objc_setAssociatedObject(self, ASSOCIATIVE_CURRENT_TEXT_KEY, currentText, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableString *)currentText {
    return objc_getAssociatedObject(self, ASSOCIATIVE_CURRENT_TEXT_KEY);
}

+ (NSString *)URLString:(NSString *)urlString appendParameters:(NSDictionary *)parameters {
    if ([urlString hasSuffix:@"/"]&&urlString.length > 1) {
        urlString = [urlString substringToIndex:urlString.length-1];
    }
    if ([urlString rangeOfString:@"?"].location == NSNotFound) {
        urlString = [urlString stringByAppendingString:@"?"];
    } else {
        urlString = [urlString stringByAppendingString:@"&"];
    }
    
    for (NSString *key in parameters) {
        NSString *value = [parameters valueForKey:key];
        urlString = [urlString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    urlString = [urlString substringToIndex:urlString.length - 1];
    return urlString;
}

- (NSString *)encodeURL {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@"!*'();:@&=+$.,/?%#[]", kCFStringEncodingUTF8);
}

- (NSString *)hmacSha1WithKey:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return hash;
}

- (NSDate *)date {
    NSTimeInterval timeInterval=self.floatValue;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

+ (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLog(@"time: %f", second);
    if (second/3600 >= 1) {
        NSString *str = [NSString stringWithFormat:@"%.2d",(int)second/3600];
        [formatter setDateFormat:[NSString stringWithFormat:@"%@:mm:ss", str]];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}//3681

@end
