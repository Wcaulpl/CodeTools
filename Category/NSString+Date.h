//
//  NSString+Date.h
//  PowerManagement
//
//  Created by CETzxy on 2018/10/24.
//  Copyright © 2018年 cet. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ymdhmsS @"yyyy-MM-dd HH:mm:ss.SSS"
#define ymdhms @"yyyy-MM-dd HH:mm:ss"
#define ymd @"yyyy-MM-dd"

@interface NSString (Date)

/*
 以 Formatter 字符串调用
 */
- (NSString *)stringWithTimeIntervalSince1970:(NSTimeInterval)msecs; // 毫秒

- (NSString *)stringFromDate:(NSDate *)date;

- (NSDate *)dateFromString:(NSString *)dateString;

//根据日期获得是周几，周一就返回1，以此类推
- (int)dateStringTheDayOfTheWeek;

// 获取当月的天数
- (NSInteger)dateStringNumberOfDaysInMonth;

// 获取当月的天数
- (NSTimeInterval)dateStringTimeIntervalSince1970;

@end
