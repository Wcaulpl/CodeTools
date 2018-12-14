//
//  UIButton+XYExtension.h
//  XYAutoScrollLabel
//
//  Created by CETzxy on 2018/12/13.
//  Copyright © 2018年 CETzxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    buttonModeTop,
    buttonModeBottom,
    buttonModeLeft,
    buttonModeRight,
} XYButtonMode;

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XYExtension)

- (void)xy_locationAdjustWithMode:(XYButtonMode)buttonMode spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
