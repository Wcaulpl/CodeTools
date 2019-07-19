//
//  UINavigationController+XYBase.m
//  CodeToolsDemo
//
//  Created by htmj on 2019/7/19.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "UINavigationController+XYBase.h"
#import <objc/runtime.h>

#define CTNAVGATION_HimageName @"navHigh_bg.png"
#define CTNAVGATION_ImageName @"nav_bg.png"
#define XYBarTintColor [UIColor blueColor]

#define backImageIcon @""
#define firstImageIcon @""



@implementation UIViewController (XYHandlerNavigationBar)

- (BOOL)xy_prefersSide_slipBackEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.xy_prefersSide_slipBackEnabled = YES;
    return YES;
}

- (void)setXy_prefersSide_slipBackEnabled:(BOOL)enabled {
    objc_setAssociatedObject(self, @selector(xy_prefersSide_slipBackEnabled), @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface UINavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation UINavigationController (XYBase)

+ (void)load {
    
    Method originMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method swizzedMethod = class_getInstanceMethod(self, @selector(xy_base_pushViewController:animated:));
    method_exchangeImplementations(originMethod, swizzedMethod);
    
}

//- (void)xy_base_viewDidLoad {
//    [self xy_base_viewDidLoad];
//
//    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        [self.navigationBar setBackgroundImage:[UIImage imageNamed:CTNAVGATION_HimageName] forBarMetrics:UIBarMetricsDefault];
//    } else {
//        [self.navigationBar setBackgroundImage:[UIImage imageNamed:CTNAVGATION_ImageName] forBarMetrics:UIBarMetricsDefault];
//    }
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
//    self.navigationBar.barTintColor = XYBarTintColor;
//    self.interactivePopGestureRecognizer.delegate = self;
//}

- (void)xy_base_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    if(self.childViewControllers.count){
        // 如果push进来的不是第一个控制器
        [button setImage:[UIImage imageNamed:backImageIcon] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        [button setImage:[UIImage imageNamed:firstImageIcon] forState:UIControlStateNormal];
        [button.imageView setContentMode:UIViewContentModeScaleToFill];
//        [button addTarget:self action:@selector(centManager) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    // Forward to primary implementation.
    [self xy_base_pushViewController:viewController animated:animated];
}

- (void)xy_pushViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    
    for (UIViewController *viewController in viewControllers) {
        if (![self.viewControllers containsObject:viewController]) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 40, 40);
            // 如果push进来的不是第一个控制器
            [button setImage:[UIImage imageNamed:backImageIcon] forState:UIControlStateNormal];
            button.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            // 修改导航栏左边的item
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    
    [self setViewControllers:[self.viewControllers arrayByAddingObjectsFromArray:viewControllers] animated:animated];
}

- (void)xy_replaceViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    // 如果push进来的不是第一个控制器
    [button setImage:[UIImage imageNamed:backImageIcon] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 隐藏tabbar
    viewController.hidesBottomBarWhenPushed = YES;
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    
    [viewControllers replaceObjectAtIndex:viewControllers.count-1 withObject:viewController];
    
    [self setViewControllers:viewControllers animated:animated];

}

- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if(self.childViewControllers.count > 0){
        return self.visibleViewController.xy_prefersSide_slipBackEnabled;
    } else {
        return NO;
    }
}


@end
