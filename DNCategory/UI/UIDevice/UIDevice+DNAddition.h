//
//  UIDevice+DNAddition.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DNAddition)

+ (NSString *)systemVersion; /**<获取系统版本号*/

+ (NSUInteger)totalMemoryBytes;/**<获取手机内存总量, 返回的是字节数*/
+ (NSUInteger)freeMemoryBytes; /**<获取手机可用内存, 返回的是字节数*/

+ (long long)freeDiskSpaceBytes;/**<获取手机硬盘空闲空间, 返回的是字节数*/
+ (long long)totalDiskSpaceBytes;/**<获取手机硬盘总空间, 返回的是字节数*/

+ (BOOL)hasCamera;/**<判断当前系统是否有摄像头*/

@end
