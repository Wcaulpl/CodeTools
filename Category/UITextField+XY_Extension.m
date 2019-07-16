//
//  UITextField+XY_Extension.m
//  DDPay
//
//  Created by htmj on 2019/7/15.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "UITextField+XY_Extension.h"
#import "UIView+XY_Extension.h"

@interface UITextField ()

@property (nonatomic, assign) BOOL xy_addNoti;

@property (nonatomic, weak) UILabel *xy_errorMsgLabel;

@property (nonatomic, weak) UIButton *xy_rightBtn;

@end

@implementation UITextField (XY_Extension)

- (void)dealloc {
    if(self.xy_addNoti == YES) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];

    }
    if(self.xy_errorMsgLabel != nil) {
        [self.xy_errorMsgLabel removeFromSuperview];
        objc_setAssociatedObject(self, @selector(xy_errorMsgLabel), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)xy_setRightView {
    [self xy_rightBtn];
}

- (void)xy_fixMessyDisplay {
    [self xy_addTextChangeNoti];
}

- (void)xy_addTextChangeNoti {
    if(self.xy_addNoti == NO) {
        // 当UITextField的文字发生改变时，UITextField自己会发出一个UITextFieldTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xy_textDidChange) name:UITextFieldTextDidChangeNotification object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xy_textEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
    }
    self.xy_addNoti = YES;
}

- (void)xy_textDidChange {
    if ([self.text isEqualToString:@" "]) {
        self.text = @"";
    }
    
    if (self.xy_textVerifications) {
        [self isVerification_success];
        self.xy_textVerifications();
    }
}

- (BOOL)isVerification_success {
    BOOL isValidate = self.xy_textRegex ? self.xy_textRegex(self.text) : self.xy_regexStr ? [self.text isValidateWithRegex:self.xy_regexStr] : YES;
    return self.xy_isValidate = isValidate || (self.xy_optional && !self.text.length);
}

- (void)xy_textEndEditing {
    self.text = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.xy_textRegex || self.xy_regexStr) {
        self.xy_errorMsgLabel.hidden = self.isVerification_success;
        self.xy_errorMsgLabel.text = self.xy_errorMsg ?:@"输入内容有误，请核对后重新输入";
    }
}

- (void)eyesAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.secureTextEntry = !btn.selected;
}

#pragma  setget
- (void)setXy_textVerifications:(void (^)(void))xy_textVerifications {
    objc_setAssociatedObject(self, &@selector(xy_textVerifications), xy_textVerifications, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self xy_fixMessyDisplay];
}

- (void (^)(void))xy_textVerifications {
    id handle = objc_getAssociatedObject(self, &@selector(xy_textVerifications));
    return handle;
}

- (void)setXy_textRegex:(BOOL (^)(NSString * _Nonnull))xy_textRegex {
    objc_setAssociatedObject(self, &@selector(xy_textRegex), xy_textRegex, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self xy_fixMessyDisplay];
}

- (BOOL (^)(NSString * _Nonnull))xy_textRegex {
    id handle = objc_getAssociatedObject(self, &@selector(xy_textRegex));
    return handle;
}

- (void)setXy_shouldChangeSecure:(BOOL)xy_shouldChangeSecure {
    objc_setAssociatedObject(self, &@selector(xy_shouldChangeSecure), [NSNumber numberWithBool:xy_shouldChangeSecure], OBJC_ASSOCIATION_ASSIGN);
    if (xy_shouldChangeSecure) {
        [self xy_setRightView];
    }
}

- (BOOL)xy_shouldChangeSecure {
    BOOL obj = [objc_getAssociatedObject(self, &@selector(xy_shouldChangeSecure)) boolValue];
    return obj;
}

- (void)setXy_addNoti:(BOOL)xy_addNoti {
    objc_setAssociatedObject(self, &@selector(xy_addNoti), [NSNumber numberWithBool:xy_addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xy_addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, &@selector(xy_addNoti)) boolValue];
    return obj;
}

- (void)setXy_isValidate:(BOOL)xy_isValidate {
    objc_setAssociatedObject(self, &@selector(xy_isValidate), [NSNumber numberWithBool:xy_isValidate], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xy_isValidate {
    BOOL obj = [objc_getAssociatedObject(self, &@selector(xy_isValidate)) boolValue];
    return obj;
}

- (void)setXy_optional:(BOOL)xy_optional {
    objc_setAssociatedObject(self, &@selector(xy_optional), [NSNumber numberWithBool:xy_optional], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xy_optional {
    BOOL obj = [objc_getAssociatedObject(self, &@selector(xy_optional)) boolValue];
    return obj;
}

- (UIButton *)xy_rightBtn {
    
    UIButton *obj = objc_getAssociatedObject(self, @selector(xy_rightBtn));
    if(obj == nil) {
        obj = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [obj setImage:[UIImage imageNamed:@"regist_eyes"] forState:(UIControlStateNormal)];
        [obj setImage:[UIImage imageNamed:@"regist_eyes_close"] forState:(UIControlStateSelected)];
        self.rightViewMode = UITextFieldViewModeAlways;
        [obj addTarget:self action:@selector(eyesAction:) forControlEvents:(UIControlEventTouchUpInside)];
        obj.frame = CGRectMake(0, (CGRectGetHeight(self.frame) - 24)/2, 24, 24);
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, CGRectGetHeight(self.frame))];
        [backView addSubview:obj];
        self.rightView = backView;
        objc_setAssociatedObject(self, @selector(xy_rightBtn), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (UILabel *)xy_errorMsgLabel {
    
    UILabel *obj = objc_getAssociatedObject(self, @selector(xy_errorMsgLabel));
    if(obj == nil) {
        obj = [[UILabel alloc]initWithFrame:CGRectMake(5, self.xy_height-15, self.xy_width-10, 15)];
        obj.numberOfLines = 1;
        obj.textAlignment = NSTextAlignmentRight;
        obj.textColor = [UIColor redColor];
        obj.font = [UIFont fontWithName:@"PingFang-SC-Regular" size: 12];
        obj.userInteractionEnabled = NO;
        obj.backgroundColor = [UIColor clearColor];
        [self addSubview:obj];
        objc_setAssociatedObject(self, @selector(xy_errorMsgLabel), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (void)setXy_regexStr:(NSString *)xy_regexStr {
    objc_setAssociatedObject(self, &@selector(xy_regexStr), xy_regexStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self xy_fixMessyDisplay];
}

- (NSString *)xy_regexStr {
    NSString *obj = objc_getAssociatedObject(self, &@selector(xy_regexStr));
    return obj;
}

- (void)setXy_errorMsg:(NSString *)xy_errorMsg {
    objc_setAssociatedObject(self, &@selector(xy_errorMsg), xy_errorMsg, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self xy_fixMessyDisplay];
}

- (NSString *)xy_errorMsg {
    NSString *obj = objc_getAssociatedObject(self, &@selector(xy_errorMsg));
    return obj;
}

@end
