//
//  XYAppIconTools.h
//  XYAppIconDemo
//
//  Created by CETzxy on 2019/2/1.
//  Copyright © 2019年 CETzxy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYAppIconTools : NSObject

/**
 返回当前正在使用的图标的名称。
 
 @return 图标名称
 */
+ (NSString *)xy_appIconName;

/**
 检查当前设备是否支持备用图标

 @return result, YES or NO
 */
+ (BOOL)xy_supportsAlternateIcons;

/**
 更改图标
 
 *传递“nil”以使用主应用程序图标。完成处理程序将在任意后台队列上异步调用；在进行任何进一步的UI工作之前，请确保将其分派回主队列。
 
 @param iconName iconName
 @param completionHandler error or nil
 */
+ (void)xy_setAlternateIconsWithIconName:(NSString *)iconName completionHandler:(nullable void (^)(NSError *_Nullable error))completionHandler NS_EXTENSION_UNAVAILABLE("Extensions may not have alternate icons");

@end

NS_ASSUME_NONNULL_END
