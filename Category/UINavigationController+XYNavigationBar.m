//
//  UINavigationController+XYNavigationBar.m
//  DDPay
//
//  Created by htmj on 2019/7/15.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "UINavigationController+XYNavigationBar.h"
#import <objc/runtime.h>

typedef void(^XYViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (XYHandlerNavigationBarPrivate)

@property(nonatomic, copy) XYViewControllerWillAppearInjectBlock xy_willAppearInjectBlock;

@end

// MARK: - 替换UIViewController的viewWillAppear方法，在此方法中，执行设置导航栏隐藏和显示的代码块。
@implementation UIViewController (XYHandlerNavigationBarPrivate)

+ (void)load
{
    Method orginalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(xy_navigationBar_viewWillAppear:));
    method_exchangeImplementations(orginalMethod, swizzledMethod);
}

- (void)xy_navigationBar_viewWillAppear:(BOOL)animated
{
    [self xy_navigationBar_viewWillAppear:animated];
    
    if (self.xy_willAppearInjectBlock) {
        self.xy_willAppearInjectBlock(self, animated);
    }
}

- (XYViewControllerWillAppearInjectBlock)xy_willAppearInjectBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setXy_willAppearInjectBlock:(XYViewControllerWillAppearInjectBlock)block
{
    objc_setAssociatedObject(self, @selector(xy_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

// MARK: - 给UIViewController添加xy_prefersNavigationBarHidden属性

@implementation UIViewController (XYHandlerNavigationBar)

- (BOOL)xy_prefersNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXy_prefersNavigationBarHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(xy_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

// MARK: - 替换UINavigationController的pushViewController:animated:方法，在此方法中去设置导航栏的隐藏和显示
@implementation UINavigationController (XYNavigationBar)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method swizzedMethod = class_getInstanceMethod(self, @selector(xy_navigationBar_pushViewController:animated:));
    method_exchangeImplementations(originMethod, swizzedMethod);
    
    Method originSetViewControllersMethod = class_getInstanceMethod(self, @selector(setViewControllers:animated:));
    Method swizzedSetViewControllersMethod = class_getInstanceMethod(self, @selector(xy_navigationBar_setViewControllers:animated:));
    method_exchangeImplementations(originSetViewControllersMethod, swizzedSetViewControllersMethod);
}

- (void)xy_navigationBar_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // Handle perferred navigation bar appearance.
    [self xy_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    // Forward to primary implementation.
    [self xy_navigationBar_pushViewController:viewController animated:animated];
}

- (void)xy_navigationBar_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    // Handle perferred navigation bar appearance.
    for (UIViewController *viewController in viewControllers) {
        [self xy_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    }
    
    // Forward to primary implementation.
    [self xy_navigationBar_setViewControllers:viewControllers animated:animated];
}

- (void)xy_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController
{
    if (!self.xy_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    // 即将被调用的代码块
    __weak typeof(self) weakSelf = self;
    XYViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.xy_prefersNavigationBarHidden animated:animated];
        }
    };
    
    // 给即将显示的控制器，注入代码块
    appearingViewController.xy_willAppearInjectBlock = block;
    
    // 因为不是所有的都是通过push的方式，把控制器压入stack中，也可能是"-setViewControllers:"的方式，所以需要对栈顶控制器做下判断并赋值。
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.xy_willAppearInjectBlock) {
        disappearingViewController.xy_willAppearInjectBlock = block;
    }
}

- (BOOL)xy_viewControllerBasedNavigationBarAppearanceEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.xy_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setXy_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled
{
    SEL key = @selector(xy_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

