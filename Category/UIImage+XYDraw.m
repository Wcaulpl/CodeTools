//
//  UIImage+XYDraw.m
//  DDPay
//
//  Created by htmj on 2019/7/17.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "UIImage+XYDraw.h"

@implementation UIImage (XYDraw)

+ (UIImage *)imageWithQRString:(NSString *)text QRSize:(CGSize)size {
    NSData *stringData = [text dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    
    
    
    CIImage *qrImage = qrFilter.outputImage;
    
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

+ (UIImage *)imageWithQRString:(NSString*)text QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor {
    
    NSData *stringData = [text dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bkColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}


- (UIImage *)synthesizedWithImage:(UIImage *)image centerOffset:(CGPoint)centerOffset; {
    // 开启绘图, 获取图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 把自己画上去 (这里是以图形上下文, 左上角为(0,0)点
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];

    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    CGFloat imageX = (self.size.width - imageW) * 0.5 +centerOffset.x;
    CGFloat imageY = (self.size.height - imageH) * 0.5 +centerOffset.y;
    [image drawInRect:CGRectMake(imageX, imageY, imageW, imageH)];
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}

@end
