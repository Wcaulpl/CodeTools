//
//  NSString+Date.m
//  PowerManagement
//
//  Created by CETzxy on 2018/10/24.
//  Copyright © 2018年 cet. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

- (NSString *)stringWithTimeIntervalSince1970:(NSTimeInterval)msecs {
    NSString *formatter = self;
    if ([self isEqualToString:ymdhmsS]) {
        formatter = ymdhms;
    }
    NSString *dateStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:msecs/1000.0]];
    
    if ([self isEqualToString:ymdhmsS]) {
        NSString *mseStr = [NSString stringWithFormat:@"%.3lf", msecs/1000];
        dateStr = [dateStr stringByAppendingString:[mseStr substringFromIndex:mseStr.length-4]];
    }
    return dateStr;
}

- (NSTimeInterval)dateStringTimeIntervalSince1970 {
    NSTimeInterval timeInterval = [[ymdhmsS dateFromString:self] timeIntervalSince1970];
    return timeInterval *1000;
}


//根据日期获得是周几，周一就返回1，以此类推
- (int)dateStringTheDayOfTheWeek {
    
    NSDateFormatter *inputFormatter=[[NSDateFormatter alloc]init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *formatterDate=[inputFormatter dateFromString:self];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:formatterDate];
    
    return [comps weekday]-1;
}

// 获取当月的天数
- (NSInteger)dateStringNumberOfDaysInMonth {
    NSDateFormatter *inputFormatter=[[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate=[inputFormatter dateFromString:self];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSGregorianCalendar - ios 8
      NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay  //NSDayCalendarUnit - ios8
                                     inUnit:NSCalendarUnitMonth //NSMonthCalendarUnit - ios 8
                                    forDate:currentDate];
    return range.length;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:self];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:self];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

@end
