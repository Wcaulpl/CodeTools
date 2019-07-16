//
//  UILabel+XYTime.h
//  DDPay
//
//  Created by htmj on 2019/7/8.
//  Copyright © 2019年 htmj. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XYTime)

/*
 * time 倒计时时间 s
 * timeChanged time改变回调
 */

- (void)xy_countdownWithTime:(NSInteger)time timeChanged:(void (^)(NSInteger seconds))timeChanged;

@end

NS_ASSUME_NONNULL_END
