//
//  UITextView+XY_Extension.h
//  DDPay
//
//  Created by htmj on 2019/7/8.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (XY_Extension)

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *xy_placeholderStr;

/**
 *  占位文字字号
 */
@property (nonatomic, strong) UIFont *xy_placeholderFont;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *xy_placeholderColor;

/**
 *  最大显示字符限制(会自动根据该属性截取文本字符长度)
 */
@property (nonatomic, assign) NSInteger xy_maximumLimit;

/**
 *  右下角字符长度提示(需要设置xy_maximumLimit属性)  默认NO
 */
@property (nonatomic, assign) BOOL xy_characterLengthPrompt;

/**
 *  右下角字符长度提示文字字号
 */
@property (nonatomic, strong) UIFont *xy_charactersLengthFont;

/**
 *  右下角字符长度提示文字颜色
 */
@property (nonatomic, strong) UIColor *xy_charactersLengthColor;

/**
 *  文本发生改变时回调
 */
- (void)xy_textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
 */
- (void)xy_fixMessyDisplay;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
