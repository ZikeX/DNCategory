//
//  UITableView+DNEmptyView.m
//  ReadingGroup
//
//  Created by mainone on 16/7/29.
//  Copyright © 2016年 mainone. All rights reserved.
//

#import "UITableView+DNEmptyView.h"
#import <objc/runtime.h>

@implementation UITableView (DNEmptyView)
static const BOOL loadingKey;
static const char loadedImageNameKey;
static const char descriptionTextKey;
static const CGFloat dataVerticalOffsetKey;

#pragma mark set Mettod
- (void)setLoading:(BOOL)loading {
    if (self.loading == loading) {
        return;
    }
    // 这个&loadingKey也可以理解成一个普通的字符串key，用这个key去内存寻址取值
    objc_setAssociatedObject(self, &loadingKey, @(loading), OBJC_ASSOCIATION_ASSIGN);
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    [self reloadEmptyDataSet];
}

- (void)setLoadedImageName:(NSString *)loadedImageName {
    objc_setAssociatedObject(self, &loadedImageNameKey, loadedImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setDataVerticalOffset:(CGFloat)dataVerticalOffset {
    objc_setAssociatedObject(self, &dataVerticalOffsetKey,@(dataVerticalOffset),OBJC_ASSOCIATION_RETAIN);// 如果是对象，请用RETAIN。坑
}

- (void)setDescriptionText:(NSString *)descriptionText {
    objc_setAssociatedObject(self, &descriptionTextKey, descriptionText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark get Mettod
- (BOOL)loading {
    // 注意，取出的是一个对象，不能直接返回
    id tmp = objc_getAssociatedObject(self, &loadingKey);
    NSNumber *number = tmp;
    return number.unsignedIntegerValue;
}

- (NSString *)loadedImageName {
    return objc_getAssociatedObject(self, &loadedImageNameKey);
}

- (CGFloat)dataVerticalOffset {
    id temp = objc_getAssociatedObject(self, &dataVerticalOffsetKey);
    NSNumber *number = temp;
    return number.floatValue;
}

-(NSString *)descriptionText {
    return objc_getAssociatedObject(self, &descriptionTextKey);
}

#pragma mark - DZNEmptyDataSetSource
// 返回一张空状态的图片在文字上面的
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        return nil;
    }
    else {
        NSString *imageName = @"placeholder_fancy";
        if (self.loadedImageName) {
            imageName = self.loadedImageName;
        }
        return [UIImage imageNamed:imageName];
    }
}

// 空状态下的文字详情
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        return nil;
    } else {
        NSString *text = @"没有数据！您可以尝试重新获取";
        if (self.descriptionText) {
            text = self.descriptionText;
        }
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     NSParagraphStyleAttributeName: paragraph};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
}

// 返回试图的垂直位置（调整整个试图的垂直位置）
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.dataVerticalOffset != 0) {
        return self.dataVerticalOffset;
    }
    return 0.0;
}

#pragma mark - DZNEmptyDataSetDelegate Methods
// 返回是否显示空状态的所有组件，默认:YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
// 返回是否允许交互，默认:YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    // 只有非加载状态能交互
    return !self.loading;
}
// 返回是否允许滚动，默认:YES
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
// 返回是否允许空状态下的图片进行动画，默认:NO
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}
//  点击空状态下的view会调用
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    
}


@end
