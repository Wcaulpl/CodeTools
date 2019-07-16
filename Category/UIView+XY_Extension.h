//
//  UIView+XY_Extension.h
//  DDPay
//
//  Created by htmj on 2019/7/8.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+XY_Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XY_Extension)

/** view.width */
@property (nonatomic, assign) CGFloat xy_width;

/** view.height */
@property (nonatomic, assign) CGFloat xy_height;

/** view.origin.x */
@property (nonatomic, assign) CGFloat xy_left;

/** view.origin.y */
@property (nonatomic, assign) CGFloat xy_top;

/** view.origin.x + view.width */
@property (nonatomic, assign) CGFloat xy_right;

/** view.origin.y + view.height */
@property (nonatomic, assign) CGFloat xy_bottom;

/** view.center.x */
@property (nonatomic, assign) CGFloat xy_centerx;

/** view.center.y */
@property (nonatomic, assign) CGFloat xy_centery;

/** view.origin */
@property (nonatomic, assign) CGPoint xy_origin;

/** view.size */
@property (nonatomic, assign) CGSize xy_size;

/** 找到自己的所属viewController */
- (UIViewController *)xy_belongsViewController;

/** 找到当前显示的viewController */
- (UIViewController *)xy_currentViewController;

/** 创建view */
+ (UIView *)xy_createViewWithFrame:(CGRect)frame color:(UIColor *)color;

/** 添加手势点击事件 */
- (void)xy_addGestureAction:(id)target selector:(SEL)selector;

/**
 * 根据键盘的弹出与收回，自动调整控件位置，防止键盘遮挡输入框,注意，如果调用该方法，则必须在父控制器的dealloc方法中调用releaseKeyboardNotification方法,以释放键盘监听通知
 @ param mainView 要移动的主视图，控制器view(controller.view)
 */
- (void)xy_automaticFollowKeyboard:(UIView *)mainView;

/**
 * 释放监听键盘的通知,如果调用过automaticFollowKeyboard方法，则必须在父控制器的dealloc方法中调用本方法以释放键盘监听通知
 */
- (void)xy_releaseKeyboardNotification;

/** 添加收起键盘的手势 */
- (void)xy_gestureHidingkeyboard;

@end

NS_ASSUME_NONNULL_END
