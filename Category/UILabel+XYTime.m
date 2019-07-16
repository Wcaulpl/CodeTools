//
//  UILabel+XYTime.m
//  DDPay
//
//  Created by htmj on 2019/7/8.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "UILabel+XYTime.h"

@implementation UILabel (XYTime)

- (void)xy_countdownWithTime:(NSInteger)time timeChanged:(void (^)(NSInteger seconds))timeChanged {
    __block NSInteger totaltime = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置按钮的样式
            if (timeChanged) {
                timeChanged(totaltime);
            }
        });
        if (totaltime <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
        } else {
            totaltime--;
        }
    });
    dispatch_resume(_timer);
}

@end
