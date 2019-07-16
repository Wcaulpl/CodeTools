//
//  NSString+XYDrop.h
//  DDPay
//
//  Created by htmj on 2019/7/12.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XYDrop)

/** 选中 */
@property (nonatomic, assign) BOOL select;

/** 选中 */
@property (nonatomic, assign) BOOL isSelected;
/** 类型 */
@property (nonatomic, assign) NSUInteger type;

/** 筛选视图 */
@property (nonatomic, strong) UIView *screenView;

/** 筛选视图高度 */
@property (nonatomic, assign) CGFloat screenHeight;

@end

NS_ASSUME_NONNULL_END
