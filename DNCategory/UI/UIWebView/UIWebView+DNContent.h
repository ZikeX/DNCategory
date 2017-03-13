//
//  UIWebView+DNContent.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (DNContent)

- (NSString *)getCurrentURL;/**<获取当前页面URL*/
- (NSString *)getTitle;/**<获取标题*/
- (NSArray *)getImgs;/**<获取图片*/
- (NSArray *)getOnClicks;/**<获取当前页面所有链接*/
- (NSArray *)getMetaData;/**<获取网页meta信息*/


- (NSString *)getContentWithID:(NSString *)tagID;/**<获取input标签中id为tagID的value*/
- (NSString *)getShareTitle;/**<获取分享标题*/
- (NSString *)getShareImage;/**< 获取分享图片*/
- (NSString *)getSharecontent;/**<获取分享内容*/
- (NSString *)getShareURL;/**<获取分享链接*/
- (NSString *)getVideoUrl;/**<获取播放链接*/

@end
