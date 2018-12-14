//
//  UIControl+ClickRepeatedly.h
//  XYAutoScrollLabel
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 CETzxy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (ClickRepeatedly)

/**
 *  设置点击的间隔（防止反复点击）
 */
@property (nonatomic, assign)NSTimeInterval clickInterval;

@property (nonatomic, assign)BOOL ignoreClick;

@end

NS_ASSUME_NONNULL_END
