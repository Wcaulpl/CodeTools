//
//  NSDate+XYAttribute.h
//  CodeToolsDemo
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 Wcaulpl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (XYAttribute)

@property (nonatomic, assign, readonly)BOOL xy_isToday;//是不是今天
@property (nonatomic, assign, readonly)NSTimeInterval xy_timeInterval;//时间戳


@property (nonatomic, assign, readonly)NSInteger xy_year;//公历年
@property (nonatomic, assign, readonly)NSInteger xy_month;//公历月
@property (nonatomic, assign, readonly)NSInteger xy_day;//公历日
@property (nonatomic, copy, readonly)NSString *xy_englishWeek;//英文日期
@property (nonatomic, copy, readonly)NSString *xy_holiday;//公历节日


@property (nonatomic, copy, readonly)NSString *xy_nlYear;//农历年
@property (nonatomic, copy, readonly)NSString *xy_nlMonth;//农历月
@property (nonatomic, copy, readonly)NSString *xy_nlDay;//农历日
@property (nonatomic, copy, readonly)NSString *xy_chineseWeek;//中文星期
@property (nonatomic, copy, readonly)NSString *xy_nlHoliday;//农历节日

@property (nonatomic, copy, readonly)NSString *xy_solarTerms;//节气

@end

NS_ASSUME_NONNULL_END
