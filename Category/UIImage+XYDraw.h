//
//  UIImage+XYDraw.h
//  DDPay
//
//  Created by htmj on 2019/7/17.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XYDraw)

+ (UIImage *)imageWithQRString:(NSString *)text QRSize:(CGSize)size;

+ (UIImage *)imageWithQRString:(NSString*)text QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor;

- (UIImage *)synthesizedWithImage:(UIImage *)image centerOffset:(CGPoint)centerOffset;

@end

NS_ASSUME_NONNULL_END
