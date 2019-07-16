//
//  NSString+XYDrop.m
//  DDPay
//
//  Created by htmj on 2019/7/12.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "NSString+XYDrop.h"

@implementation NSString (XYDrop)

- (void)setIsSelected:(BOOL)isSelected {
    objc_setAssociatedObject(self, &@selector(isSelected),  [NSNumber numberWithBool:isSelected], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSelected {
    id obj = objc_getAssociatedObject(self, &@selector(isSelected));
    return [obj boolValue];
}

- (void)setSelect:(BOOL)select {
    objc_setAssociatedObject(self, &@selector(select),  [NSNumber numberWithBool:select], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)select {
    id obj = objc_getAssociatedObject(self, &@selector(select));
    return [obj boolValue];
}

- (void)setType:(NSUInteger)type {
    objc_setAssociatedObject(self, &@selector(type),  [NSNumber numberWithUnsignedInteger:type], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)type {
    id obj = objc_getAssociatedObject(self, &@selector(type));
    return [obj unsignedIntegerValue];
}

- (UIView *)screenView {
    UIView *obj = objc_getAssociatedObject(self, @selector(screenView));
    if(obj == nil) {
        obj = UIView.new;
        obj.backgroundColor = [UIColor whiteColor];
        objc_setAssociatedObject(self, @selector(screenView), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (void)setScreenView:(UIView *)screenView {
    self.screenHeight = CGRectGetHeight(screenView.frame);
    objc_setAssociatedObject(self, @selector(screenView), screenView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setScreenHeight:(CGFloat)screenHeight {
    objc_setAssociatedObject(self, &@selector(screenHeight),  [NSNumber numberWithFloat:screenHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)screenHeight {
    id obj = objc_getAssociatedObject(self, &@selector(screenHeight));
    CGFloat height = [obj floatValue];
    if (!height) {
        height = 100.f;
    }
    return height;
}

@end
