//
//  XYScrollLabel.h
//  PowerManagement
//
//  Created by CETzxy on 2018/11/9.
//  Copyright © 2018年 cet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AutoScrollDirection) {
    AutoScrollDirectionRight,
    AutoScrollDirectionLeft
};

NS_ASSUME_NONNULL_BEGIN

@interface XYAutoScrollLabel : UIView <UIScrollViewDelegate>

@property (nonatomic) AutoScrollDirection scrollDirection; // 滚动方向

@property (nonatomic) float scrollSpeed; // 滚动速度 默认 30s
@property (nonatomic) NSTimeInterval pauseInterval; // 默认 1.5
@property (nonatomic) NSInteger labelSpacing; // 默认 20

@property (nonatomic, assign) CGFloat maxWidth; // 最大 宽度 默认 屏宽  或initWithFrame 的 frame.size.width
@property (nonatomic, assign) CGFloat minHeight; // 最小 高度度 默认 0  或initWithFrame 的 frame.size.height

/**
 * 滚动UILabels时使用的动画选项
 * @discussion UIViewAnimationOptionAllowUserInteraction 总是应用于动画。
 */
@property (nonatomic) UIViewAnimationOptions animationOptions;

/**
 * 如果它正在主动滚动 返回YES，如果它已暂停或文本在界限内，则返回NO（禁用滚动）。
 */
@property (nonatomic, readonly) BOOL scrolling;
@property (nonatomic) CGFloat fadeLength; // defaults to 7

// UILabel properties
@property (nonatomic, strong, nonnull) UIFont *font;
@property (nonatomic, copy, nullable) NSString *text;
@property (nonatomic, copy, nullable) NSAttributedString *attributedText;
@property (nonatomic, strong, nonnull) UIColor *textColor;
@property (nonatomic) NSTextAlignment textAlignment; // 只在不自动滚动时适用
@property (nonatomic, strong, nullable) UIColor *shadowColor;
@property (nonatomic) CGSize shadowOffset;

/**
 * 布局滚动视图内容，如果文本将被剪辑，则启用文本滚动。
 * @discussion 在内部使用 [scrollLabelIfNeeded]。
 */
- (void)refreshLabels;

/**
 * 如果需要，将文本设置为标签并刷新标签。
 * @discussion 当您在设置了滚动标签的文本之后需要对它进行布局时，非常有用。
 */
- (void)setText:(nullable NSString *)text refreshLabels:(BOOL)refresh;

/**
 * 如果需要，设置属性文本并刷新标签。
 */
- (void)setAttributedText:(nullable NSAttributedString *)theText refreshLabels:(BOOL)refresh;

/**
 * 如果标签宽度超过滚动视图的边界，则启动自动滚动。
 */
- (void)scrollLabelIfNeeded;

/**
 * 观察自动重启滚动的UIApplication状态通知，并监视
 * 方向改变以刷新标签。
 * @discussion 必须调用以观察通知。多次调用将仍然仅注册通知一次。
 */
- (void)observeApplicationNotifications;

/**
 * 不能直接赋值属性
 */

- (void)setFrame:(CGRect)frame __attribute__((unavailable("call initWithFrame:")));

@end

NS_ASSUME_NONNULL_END
