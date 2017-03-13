

#import <UIKit/UIKit.h>


@interface UINavigationController (FDFullscreenPopGesture)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fd_fullscreenPopGestureRecognizer;


@property (nonatomic, assign) BOOL fd_viewControllerBasedNavigationBarAppearanceEnabled;

@end


@interface UIViewController (FDFullscreenPopGesture)

/**
 *  是否禁止侧滑
 */
@property (nonatomic, assign) BOOL fd_interactivePopDisabled;

/**
 *  导航条隐藏
 */
@property (nonatomic, assign) BOOL fd_prefersNavigationBarHidden;

/**
 *  可滑区域大小
 */
@property (nonatomic, assign) CGFloat fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
