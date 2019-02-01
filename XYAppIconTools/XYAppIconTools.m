//
//  XYAppIconTools.m
//  XYAppIconDemo
//
//  Created by CETzxy on 2019/2/1.
//  Copyright © 2019年 CETzxy. All rights reserved.
//

#import "XYAppIconTools.h"
#import "AppDelegate.h"

@implementation XYAppIconTools


+ (NSString *)xy_appIconName {
    if (@available(iOS 10.3, *)) {
        return ([UIApplication sharedApplication].alternateIconName.length == 0) ? @"" : [UIApplication sharedApplication].alternateIconName;
    } else {
        // Fallback on earlier versions
        return @"";
    }
}

+ (BOOL)xy_supportsAlternateIcons {
    if (@available(iOS 10.3, *)) {
        return [[UIApplication sharedApplication] supportsAlternateIcons];
    } else {
        // Fallback on earlier versions
        return NO;
    }
}

+ (void)xy_setAlternateIconsWithIconName:(NSString *)iconName completionHandler:(nullable void (^)(NSError *_Nullable error))completionHandler {
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                completionHandler(nil);
            } else {
                completionHandler(error);
            }
        }];
    } else {
        // Fallback on earlier versions
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"AppIcon change failed", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The current system version does not support replacing the AppIcon.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        NSError *error = [NSError errorWithDomain:@""
                                             code:34001
                                         userInfo:userInfo];
        completionHandler(error);
    }
}

@end
