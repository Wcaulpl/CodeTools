//
//  NSArray+XYConditions.m
//  WisdomPower
//
//  Created by CETzxy on 2018/12/19.
//

#import "NSArray+XYConditions.h"

@implementation NSMutableArray (XYConditions)

- (void)xy_conditionsByGenerating:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))generate {
    if (generate) {
        NSMutableArray *array = [NSMutableArray array];
        BOOL isStop = false;
        for (int i = 0; i < self.count; i++) {
            id obj = generate(self[i], i, &isStop);
            if (obj) {
                [self replaceObjectAtIndex:i withObject:obj];
            } else {
                [array addObject:self[i]];
            }
            if (isStop) {
                break;
            }
        }
        [self removeObjectsInArray:array];
    }
}

@end

@implementation NSArray (XYConditions)

- (NSArray *)xy_arrayConditionsByGenerating:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))generate {
    NSMutableArray *array = self.mutableCopy;
    [array xy_conditionsByGenerating:generate];
    return array;
}

@end
