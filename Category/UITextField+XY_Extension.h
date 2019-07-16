//
//  UITextField+XY_Extension.h
//  DDPay
//
//  Created by htmj on 2019/7/15.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+XY_Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (XY_Extension)

@property (nonatomic, copy) NSString *xy_regexStr;
/**
 *  文本输入结束 验证时回调
 */
@property (nonatomic, copy) BOOL (^xy_textRegex) (NSString *text);
/**
 *  文本输入时 验证回调
 */
@property (nonatomic, copy) void (^xy_textVerifications) (void);

@property (nonatomic, weak) NSString *xy_errorMsg;

@property (nonatomic, assign, readonly) BOOL xy_isValidate;

@property (nonatomic, assign) BOOL xy_optional; // 选填 默认 NO

@property (nonatomic, assign) BOOL xy_shouldChangeSecure;
@end

NS_ASSUME_NONNULL_END
