//
//  UITextView+XY_Extension.m
//  DDPay
//
//  Created by htmj on 2019/7/8.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "UITextView+XY_Extension.h"
#include <objc/runtime.h>
#import "UIView+XY_Extension.h"

@interface UITextView ()

@property (nonatomic, assign) BOOL xy_addNoti;

@property (nonatomic, copy) NSString *xy_lastTextStr;

@property (nonatomic, copy) void(^xy_textHandle) (NSString *textStr);

@property (nonatomic, weak) UILabel *xy_placeholderLabel;

@property (nonatomic, weak) UILabel *xy_charactersLengthLabel;

@end

@implementation UITextView (XY_Extension)

+ (void)load {
    Method orginalMethod = class_getInstanceMethod(self, @selector(setText:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(xy_setText:));
    method_exchangeImplementations(orginalMethod, swizzledMethod);
}

- (void)xy_setText:(NSString *)text {
    [self xy_setText:text];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}

- (void)setXy_addNoti:(BOOL)xy_addNoti {
    
    objc_setAssociatedObject(self, @selector(xy_addNoti), [NSNumber numberWithBool:xy_addNoti], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)xy_addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, _cmd) boolValue];
    return obj;
}

- (void)setXy_placeholderStr:(NSString *)xy_placeholderStr {
    
    objc_setAssociatedObject(self, @selector(xy_placeholderStr), xy_placeholderStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self xy_fixMessyDisplay];
    self.xy_placeholderLabel.backgroundColor = [UIColor clearColor];
}

- (NSString *)xy_placeholderStr {
    
    NSString *obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setXy_placeholderColor:(UIColor *)xy_placeholderColor {
    
    objc_setAssociatedObject(self, @selector(xy_placeholderColor), xy_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self xy_fixMessyDisplay];
    self.xy_placeholderLabel.backgroundColor = [UIColor clearColor];;
}

- (UIColor *)xy_placeholderColor {
    
    UIColor *obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setXy_placeholderFont:(UIFont *)xy_placeholderFont {
    
    objc_setAssociatedObject(self, @selector(xy_placeholderFont), xy_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.xy_placeholderLabel.backgroundColor = [UIColor clearColor];
}

- (UIFont *)xy_placeholderFont {
    
    UIFont *obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setXy_maximumLimit:(NSInteger)xy_maximumLimit {
    
    objc_setAssociatedObject(self, @selector(xy_maximumLimit), [NSNumber numberWithInteger:xy_maximumLimit], OBJC_ASSOCIATION_ASSIGN);
    [self xy_fixMessyDisplay];
}

- (NSInteger)xy_maximumLimit {
    
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj integerValue];
}

- (void)setXy_characterLengthPrompt:(BOOL)xy_characterLengthPrompt {
    
    objc_setAssociatedObject(self, @selector(xy_characterLengthPrompt), [NSNumber numberWithBool:xy_characterLengthPrompt], OBJC_ASSOCIATION_ASSIGN);
    [self xy_fixMessyDisplay];
    
//    self.xy_height = (xy_characterLengthPrompt == YES) ? self.xy_height-25 : self.xy_height+25;
    self.xy_charactersLengthLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length > (long)self.xy_maximumLimit ? (long)self.xy_maximumLimit : (unsigned long)self.text.length ,(long)self.xy_maximumLimit];
    self.xy_charactersLengthLabel.hidden = !xy_characterLengthPrompt;
}

- (BOOL)xy_characterLengthPrompt {
    
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj boolValue];
}

- (void)setXy_charactersLengthColor:(UIColor *)xy_charactersLengthColor {
    
    objc_setAssociatedObject(self, @selector(xy_charactersLengthColor), xy_charactersLengthColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self xy_fixMessyDisplay];
}

- (UIColor *)xy_charactersLengthColor {
    
    UIColor *obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setXy_charactersLengthFont:(UIFont *)xy_charactersLengthFont {
    
    objc_setAssociatedObject(self, @selector(xy_charactersLengthFont), xy_charactersLengthFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)xy_charactersLengthFont {
    
    UIFont *obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (UILabel *)xy_placeholderLabel {
    
    UILabel *obj = objc_getAssociatedObject(self, @selector(xy_placeholderLabel));
    if(obj == nil) {
        
        obj = [[UILabel alloc]init];
        obj.xy_left = 5.0f;
        obj.xy_top = 8.0f;
        obj.xy_width = self.xy_width-(obj.xy_left*2);
        obj.numberOfLines = 0;
        obj.userInteractionEnabled = NO;
        [self insertSubview:obj atIndex:0];
        
        objc_setAssociatedObject(self, @selector(xy_placeholderLabel), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.font = self.xy_placeholderFont ? self.xy_placeholderFont : self.font;
    obj.textColor = self.xy_placeholderColor ? self.xy_placeholderColor : [UIColor lightGrayColor];
    obj.text = self.xy_placeholderStr;
    [obj sizeToFit];
    
    return obj;
}

- (UILabel *)xy_charactersLengthLabel {
    
    UILabel *obj = objc_getAssociatedObject(self, @selector(xy_charactersLengthLabel));
    if(obj == nil) {
        
        obj = [[UILabel alloc]initWithFrame:CGRectMake(0, self.xy_height-25, self.xy_width-14, 25)];
        obj.backgroundColor = self.backgroundColor;
        obj.textAlignment = NSTextAlignmentRight;
        obj.userInteractionEnabled = YES;
        
        objc_setAssociatedObject(self, @selector(xy_charactersLengthLabel), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.font = self.xy_charactersLengthFont ? self.xy_charactersLengthFont : self.xy_placeholderFont ? self.xy_placeholderFont : self.font;
    obj.textColor = self.xy_charactersLengthColor ? self.xy_charactersLengthColor : self.xy_placeholderColor ? self.xy_placeholderColor : [UIColor lightGrayColor];
    
    return obj;
}

- (void)setXy_textHandle:(void (^)(NSString *))xy_textHandle {
    
    objc_setAssociatedObject(self, @selector(xy_textHandle), xy_textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))xy_textHandle {
    
    id handle = objc_getAssociatedObject(self, @selector(xy_textHandle));
    if (handle) {
        
        return (void(^)(NSString *textStr))handle;
    }
    return nil;
}

- (void)setXy_lastTextStr:(NSString *)xy_lastTextStr {
    
    objc_setAssociatedObject(self, @selector(xy_lastTextStr), xy_lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)xy_lastTextStr {
    NSString *string = objc_getAssociatedObject(self, _cmd);
    if(([string isKindOfClass:[NSNull class]]) || ([string isEqual:[NSNull null]]) || (string == nil) || (!string)) {
        
        string = @"";
    }
    
    return string;
}

- (void)xy_textDidChange:(void (^)(NSString * _Nonnull))handle {
    
    self.xy_textHandle = handle;
    [self xy_fixMessyDisplay];
}

- (void)xy_fixMessyDisplay {
    
    if(self.xy_maximumLimit <= 0) {self.xy_maximumLimit = MAXFLOAT;}
    
    if (self.xy_placeholderStr) {
        self.xy_placeholderLabel.xy_left = 5.0f;
        self.xy_placeholderLabel.xy_top = 8.0f;
        self.xy_placeholderLabel.xy_width = self.xy_width-(5.0f*2);
    }
    
    if(self.xy_characterLengthPrompt == YES) {
        if(self.xy_charactersLengthLabel.superview == nil) {
            self.xy_charactersLengthLabel.frame = CGRectMake(0, self.xy_height-25, self.xy_width-10, 25);
            [self addSubview:self.xy_charactersLengthLabel];
        }
    }
    
    [self xy_addTextChangeNoti];
}

- (void)xy_textDidChange {
    
    [self xy_characterTruncation];
}

- (void)xy_characterTruncation {
    
    //字符截取
    if(self.xy_maximumLimit > 0) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.xy_maximumLimit)) {
            
            const char *res = [self.text substringToIndex:self.xy_maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.xy_maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.xy_maximumLimit];
            }
        }
    }
    
    if((self.xy_textHandle) && (![self.text isEqualToString:self.xy_lastTextStr])) {
        
        self.xy_textHandle(self.text);
    }
    self.xy_lastTextStr = self.text;
    
    self.xy_placeholderLabel.hidden = (self.text.length > 0) ? YES : NO;
    self.xy_charactersLengthLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length > (long)self.xy_maximumLimit ? (long)self.xy_maximumLimit : (unsigned long)self.text.length ,(long)self.xy_maximumLimit];
}

- (void)xy_addTextChangeNoti {
    
    if(self.xy_addNoti == NO) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xy_textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    self.xy_addNoti = YES;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)clear {
    self.text = @"";
    [self xy_characterTruncation];
}

- (void)dealloc {
    
    if(self.xy_addNoti == YES) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
    if(self.xy_placeholderLabel != nil) {
        
        [self.xy_placeholderLabel removeFromSuperview];
        objc_setAssociatedObject(self, @selector(xy_placeholderLabel), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    if(self.xy_charactersLengthLabel != nil) {
        
        [self.xy_charactersLengthLabel removeFromSuperview];
        objc_setAssociatedObject(self, @selector(xy_charactersLengthLabel), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
}

@end
