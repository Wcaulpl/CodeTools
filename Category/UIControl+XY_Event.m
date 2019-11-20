//
//  UIControl+XY_Event.m
//  DDPay
//
//  Created by htmj on 2019/8/27.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "UIControl+XY_Event.h"
#import "LZHomeController.h"

@implementation UIControl (XY_Event)

- (void)setXy_clickInterval:(NSTimeInterval)xy_clickInterval {
    objc_setAssociatedObject(self, &@selector(xy_event), @(xy_clickInterval), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)xy_clickInterval {
    return [objc_getAssociatedObject(self, &@selector(xy_clickInterval)) doubleValue];
}

- (void)setXy_event:(BOOL)xy_event {
    objc_setAssociatedObject(self, &@selector(xy_event), [NSNumber numberWithBool:xy_event], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xy_event {
    BOOL obj = [objc_getAssociatedObject(self, &@selector(xy_event)) boolValue];
    return obj;
}

+ (void)load{
    //获取着两个方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(xy_sendAction:to:forEvent:));
    SEL mySEL = @selector(xy_sendAction:to:forEvent:);
    
    //添加方法进去
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    //如果方法已经存在了
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, myMethod);
    }
    //----------------以上主要是实现两个方法的互换,load是gcd的只shareinstance，果断保证执行一次
}

- (void)xy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (!AppDelegate.token && [AppDelegate.shared.currentViewController isKindOfClass:[LZHomeController class]] && !self.xy_event) {
        [self xy_sendAction:@selector(login) to:AppDelegate.shared forEvent:event];
        return;
    }
    [self xy_sendAction:action to:target forEvent:event];
    if (self.xy_clickInterval) {
        self.enabled = NO;
        [self performSelector:@selector(setEnabled:) withObject:@(YES) afterDelay:self.xy_clickInterval];
    }
}

@end
