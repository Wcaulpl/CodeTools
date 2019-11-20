//
//  UIControl+XY_Event.h
//  DDPay
//
//  Created by htmj on 2019/8/27.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (XY_Event)

@property (nonatomic, assign) BOOL xy_event;

@property (nonatomic, assign) NSTimeInterval xy_clickInterval;

@end

NS_ASSUME_NONNULL_END
