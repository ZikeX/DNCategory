//
//  UITableView+DNEmptyView.h
//  ReadingGroup
//
//  Created by mainone on 16/7/29.
//  Copyright © 2016年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface UITableView (DNEmptyView) <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/**
 *  是否在加载 YES:转菊花 or NO:立即空状态界面
 *  PS:在加载数据前设置为YES(必需)，随后根据数据调整为NO(可选)
 */
@property (nonatomic, assign)BOOL loading;

/**
 *  不加载状态下的图片(loading = NO)
 *  PS:空状态下显示图片
 */
@property (nonatomic, copy)NSString *loadedImageName;
@property (nonatomic, copy)NSString *descriptionText;// 空状态下的文字详情

/**
 *  视图的垂直位置
 *  PS:tableView中心点为基准点,(基准点＝0)
 */
@property (nonatomic, assign)CGFloat dataVerticalOffset;

@end
