//
//  NSString+XY_Extension.m
//  DDPay
//
//  Created by htmj on 2019/7/10.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "NSString+XY_Extension.h"

@implementation NSString (XY_Extension)

- (NSAttributedString *)xy_convertCountAttributed {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#3D8CFF" alpha:1]} range:NSMakeRange(0, self.length-3)];
    return string;
}


#pragma mark  正则判断
- (BOOL)isValidateWithRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:self];
}

#pragma mark  字符串字节数
- (NSUInteger)charactorNumber
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self charactorNumberWithEncoding:encoding];
}

- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding
{
    NSUInteger strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:encoding];
    
    NSUInteger lengthOfBytes = [self lengthOfBytesUsingEncoding:encoding];
    for (int i = 0; i < lengthOfBytes; i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

@end
