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
 * The animation options used when scrolling the UILabels.
 * @discussion UIViewAnimationOptionAllowUserInteraction is always applied to the animations.
 */
@property (nonatomic) UIViewAnimationOptions animationOptions;

/**
 * Returns YES, if it is actively scrolling, NO if it has paused or if text is within bounds (disables scrolling).
 */
@property (nonatomic, readonly) BOOL scrolling;
@property (nonatomic) CGFloat fadeLength; // defaults to 7

// UILabel properties
@property (nonatomic, strong, nonnull) UIFont *font;
@property (nonatomic, copy, nullable) NSString *text;
@property (nonatomic, copy, nullable) NSAttributedString *attributedText;
@property (nonatomic, strong, nonnull) UIColor *textColor;
@property (nonatomic) NSTextAlignment textAlignment; // only applies when not auto-scrolling
@property (nonatomic, strong, nullable) UIColor *shadowColor;
@property (nonatomic) CGSize shadowOffset;

/**
 * Lays out the scrollview contents, enabling text scrolling if the text will be clipped.
 * @discussion Uses [scrollLabelIfNeeded] internally.
 */
- (void)refreshLabels;

/**
 * Set the text to the label and refresh labels, if needed.
 * @discussion Useful when you have a situation where you need to layout the scroll label after it's text is set.
 */
- (void)setText:(nullable NSString *)text refreshLabels:(BOOL)refresh;

/**
 Set the attributed text and refresh labels, if needed.
 */
- (void)setAttributedText:(nullable NSAttributedString *)theText refreshLabels:(BOOL)refresh;

/**
 * Initiates auto-scroll, if the label width exceeds the bounds of the scrollview.
 */
- (void)scrollLabelIfNeeded;

/**
 * Observes UIApplication state notifications to auto-restart scrolling and watch for
 * orientation changes to refresh the labels.
 * @discussion Must be called to observe the notifications. Calling multiple times will still only
 * register the notifications once.
 */
- (void)observeApplicationNotifications;

@end

NS_ASSUME_NONNULL_END
