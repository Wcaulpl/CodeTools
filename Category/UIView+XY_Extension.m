//
//  UIView+XY_Extension.m
//  DDPay
//
//  Created by htmj on 2019/7/8.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "UIView+XY_Extension.h"
#include <objc/runtime.h>

@interface UIView ()

@property (nonatomic, weak) UIView *xy_mainView;

@property (nonatomic, assign) CGRect xy_mainViewFrame;

@end

@implementation UIView (XY_Extension)

- (CGFloat)xy_width {return self.frame.size.width;}
- (void)setXy_width:(CGFloat)xy_width {
    
    CGRect frame = self.frame;
    frame.size.width = xy_width;
    self.frame = frame;
}

- (CGFloat)xy_height {return self.frame.size.height;}
- (void)setXy_height:(CGFloat)xy_height {
    
    CGRect frame = self.frame;
    frame.size.height = xy_height;
    self.frame = frame;
}

- (CGFloat)xy_left {return self.frame.origin.x;}
- (void)setXy_left:(CGFloat)xy_left {
    
    CGRect frame = self.frame;
    frame.origin.x = xy_left;
    self.frame = frame;
}

- (CGFloat)xy_top {return self.frame.origin.y;}
- (void)setXy_top:(CGFloat)xy_top {
    
    CGRect frame = self.frame;
    frame.origin.y = xy_top;
    self.frame = frame;
}

- (CGFloat)xy_right {return self.frame.origin.x+self.frame.size.width;}
- (void)setXy_right:(CGFloat)xy_right {
    
    CGRect frame = self.frame;
    frame.origin.x = xy_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)xy_bottom {return self.frame.origin.y+self.frame.size.height;};
- (void)setXy_bottom:(CGFloat)xy_bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = xy_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)xy_centerx {return self.center.x;}
- (void)setXy_centerx:(CGFloat)xy_centerx {
    
    self.center = CGPointMake(xy_centerx, self.center.y);
}

- (CGFloat)xy_centery {return self.center.y;}
- (void)setXy_centery:(CGFloat)xy_centery {
    
    self.center = CGPointMake(self.center.x, xy_centery);
}

- (CGPoint)xy_origin {return self.frame.origin;}
- (void)setXy_origin:(CGPoint)xy_origin {
    
    CGRect frame = self.frame;
    frame.origin = xy_origin;
    self.frame = frame;
}

- (CGSize)xy_size {return self.frame.size;}
- (void)setXy_size:(CGSize)xy_size {
    
    CGRect frame = self.frame;
    frame.size = xy_size;
    self.frame = frame;
}

- (UIViewController *)xy_belongsViewController {
    
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIViewController *)xy_currentViewController {
    
    return [self xy_getCurrentViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
}

//递归查找
- (UIViewController *)xy_getCurrentViewController:(UIViewController *)controller {
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        
        UINavigationController *nav = ((UITabBarController *)controller).selectedViewController;
        return [nav.viewControllers lastObject];
    }
    else if ([controller isKindOfClass:[UINavigationController class]]) {
        
        return [((UINavigationController *)controller).viewControllers lastObject];
    }
    else if ([controller isKindOfClass:[UIViewController class]]) {
        
        return controller;
    }
    else {
        
        return nil;
    }
}

+ (UIView *)xy_createViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor  = color;
    
    return view;
}

- (void)xy_addGestureAction:(id)target selector:(SEL)selector {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)xy_automaticFollowKeyboard:(UIView *)mainView {
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xy_showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xy_hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    self.xy_mainView = mainView;
    self.xy_mainViewFrame = mainView.frame;
}

- (void)setXy_mainView:(UIView *)xy_mainView {
    
    objc_setAssociatedObject(self, &@selector(xy_mainView), xy_mainView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)xy_mainView {
    
    id obj = objc_getAssociatedObject(self, &@selector(xy_mainView));
    return obj;
}

- (void)setXy_mainViewFrame:(CGRect)xy_mainViewFrame {
    
    objc_setAssociatedObject(self, &@selector(xy_mainViewFrame), [NSValue valueWithCGRect:xy_mainViewFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)xy_mainViewFrame {
    
    id obj = objc_getAssociatedObject(self, &@selector(xy_mainViewFrame));
    return [obj CGRectValue];
}

- (void)xy_showKeyboard:(NSNotification *)noti {
    
    if(self.isFirstResponder == YES) {
        
        //键盘出现后的位置
        CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        //键盘弹起时的动画效果
        UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
        //键盘动画时长
        NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
        
        CGFloat bottom = [self.superview convertPoint:self.frame.origin toView:self.xy_mainView].y+self.frame.size.height;
        
        ///如果self是UITextView，则需判断是否显示了右下角提示文本，如显示，则需要加上提示文本的高度25
        if([self isKindOfClass:[UITextView class]]) {
            
            UITextView *textView = (UITextView *)self;
            if(textView.xy_characterLengthPrompt == YES) {
                
                bottom = bottom+25;
            }
        }
        CGFloat extraHeight = [self xy_hasSystemNavigationBarExtraHeight];
        
        __weak typeof(self) textFieldSelf = self;
        if((bottom+extraHeight) > keyboardFrame.origin.y) {
            
            [UIView animateWithDuration:duration delay:0 options:option animations:^{
                
                textFieldSelf.xy_mainView.xy_top = -(bottom-keyboardFrame.origin.y);
                
            } completion:^(BOOL finished) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //为了显示动画
                    [textFieldSelf layoutIfNeeded];
                });
            }];
        }
    }
}

- (void)xy_hideKeyboard:(NSNotification *)noti {
    
    UIViewAnimationOptions option= [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    __weak typeof(self) textFieldSelf = self;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        CGFloat extraHeight = [textFieldSelf xy_hasSystemNavigationBarExtraHeight];
        textFieldSelf.xy_mainView.xy_top = textFieldSelf.xy_mainViewFrame.origin.y+extraHeight;
        
    } completion:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //为了显示动画
            [textFieldSelf layoutIfNeeded];
        });
    }];
}

//计算键盘弹出时的额外高度
- (CGFloat)xy_hasSystemNavigationBarExtraHeight {
    
    //相对于导航栏高度开始的 如果设置了导航栏的translucent = YES这时在添加子视图的坐标原点相对屏幕坐标是(0,0).如果设置了translucent = NO这时添加子视图的坐标原点相对屏幕坐标就是(0, navViewHeight)
    if(([self xy_belongsViewController].navigationController != nil) && ([self xy_belongsViewController].navigationController.navigationBar.hidden == NO) && ([self xy_belongsViewController].navigationController.navigationBar.translucent == NO)) {
        
        //判断是否隐藏的电池条
        if([UIApplication sharedApplication].statusBarHidden == NO) {
            
            return [[UIApplication sharedApplication] statusBarFrame].size.height+[self xy_belongsViewController].navigationController.navigationBar.frame.size.height;
            
        }else {
            
            return [self xy_belongsViewController].navigationController.navigationBar.frame.size.height;
        }
    }
    //相对于零点开始的
    return 0.0;
}

- (void)xy_gestureHidingkeyboard {
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xy_keyboardHide)];
    gesture.numberOfTapsRequired = 1;
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    gesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:gesture];
}

- (void)xy_keyboardHide {
    
    [self endEditing:YES];
}

- (void)xy_releaseKeyboardNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
