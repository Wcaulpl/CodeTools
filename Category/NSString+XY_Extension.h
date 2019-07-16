//
//  NSString+XY_Extension.h
//  DDPay
//
//  Created by htmj on 2019/7/10.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XY_Extension)

- (NSAttributedString *)xy_convertCountAttributed;


#pragma mark  正则判断
- (BOOL)isValidateWithRegex:(NSString *)regex;


- (NSUInteger)charactorNumber;

@end

NS_ASSUME_NONNULL_END
