//
//  NSDate+Attribute.h
//  CodeToolsDemo
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 Wcaulpl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Attribute)

@property (nonatomic,assign,readonly)BOOL    xy_isToday;//是不是今天
@property (nonatomic,copy,readonly)NSString *xy_chineseWeek;//中文星期
@property (nonatomic,copy,readonly)NSString *xy_englishWeek;//英文日期
@property (nonatomic,copy,readonly)NSString *xy_date;//时间戳
@property (nonatomic,copy,readonly)NSString *xy_glYears;//公历年
@property (nonatomic,copy,readonly)NSString *xy_glMonth;//公历月
@property (nonatomic,copy,readonly)NSString *xy_glDay;//公历日

@property (nonatomic,copy,readonly)NSString *xy_nlYears;//农历年
@property (nonatomic,copy,readonly)NSString *xy_nlMonth;//农历月
@property (nonatomic,copy,readonly)NSString *xy_nlDay;//农历日

@property (nonatomic,copy,readonly)NSString *xy_SolarTerms;//节气
@property (nonatomic,copy,readonly)NSString *xy_glHoliday;//公历节日
@property (nonatomic,copy,readonly)NSString *xy_nlHoliday;//农历节日

@end

NS_ASSUME_NONNULL_END
