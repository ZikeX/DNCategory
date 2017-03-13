//
//  UIWebView+DNContent.m
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIWebView+DNContent.h"

@implementation UIWebView (DNContent)

- (int)nodeCountOfTag:(NSString *)tag {
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    int len = [[self stringByEvaluatingJavaScriptFromString:jsString] intValue];
    return len;
}

- (NSString *)getCurrentURL {
    return [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}

- (NSString *)getTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (NSArray *)getImgs {
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
    }
    return arrImgURL;
}

- (NSArray *)getOnClicks {
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"a"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%d].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        NSLog(@"%@", clickString);
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}

- (NSArray *)getMetaData {
    NSString *string = [self stringByEvaluatingJavaScriptFromString:@""
                        "var json = '[';                                    "
                        "var a = document.getElementsByTagName('meta');     "
                        "for(var i=0;i<a.length;i++){                       "
                        "   json += '{';                                    "
                        "   var b = a[i].attributes;                        "
                        "   for(var j=0;j<b.length;j++){                    "
                        "       var name = b[j].name;                       "
                        "       var value = b[j].value;                     "
                        "                                                   "
                        "       json += '\"'+name+'\":';                    "
                        "       json += '\"'+value+'\"';                    "
                        "       if(b.length>j+1){                           "
                        "           json += ',';                            "
                        "       }                                           "
                        "   }                                               "
                        "   json += '}';                                    "
                        "   if(a.length>i+1){                               "
                        "       json += ',';                                "
                        "   }                                               "
                        "}                                                  "
                        "json += ']';                                       "];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError*   error = nil;
    id array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if(array==nil) NSLog(@"An error occured in meta parser.");
    return array;
}


- (NSString *)getContentWithID:(NSString *)tagID {
    for (int i = 0; i < [self nodeCountOfTag:@"input"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('input')[%d].value", i];
        NSString *jsStringID = [NSString stringWithFormat:@"document.getElementsByTagName('input')[%d].id", i];
        if ([[self stringByEvaluatingJavaScriptFromString:jsStringID] isEqualToString:tagID]) {
            return [self stringByEvaluatingJavaScriptFromString:jsString];
        }
    }
    return nil;
}

- (NSString *)getShareTitle {
    NSString *shareTitle = [self getContentWithID:@"title_share"];
    return shareTitle;
}

- (NSString *)getShareImage {
    NSString *shareImage = [self getContentWithID:@"image_share"];
    if (shareImage.length > 0) {
        return shareImage;
    }else {
        return @"http://120.27.115.64/template/default/images/tx4.png";
    }
}

- (NSString *)getSharecontent {
    NSString *sharecontent = [self getContentWithID:@"content_share"];
    if (sharecontent.length > 0) {
        return sharecontent;
    }else {
        return @"详情";
    }
}

- (NSString *)getShareURL {
    NSString *shareURL= [self getContentWithID:@"url_share"];
    return shareURL;
    
}

- (NSString *)getVideoUrl {
    NSString *shareURL= [self getContentWithID:@"video_view"];
    return shareURL;
}

@end
