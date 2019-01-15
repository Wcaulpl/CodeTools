//
//  NSArray+XYConditions.h
//  WisdomPower
//
//  Created by CETzxy on 2018/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (XYConditions)

- (void)xy_conditionsByGenerating:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))generate; // 获取数组中每一个元素 重新配置 数组

@end

@interface NSArray (XYConditions)

- (NSArray *)xy_arrayConditionsByGenerating:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))generate;

@end

NS_ASSUME_NONNULL_END
