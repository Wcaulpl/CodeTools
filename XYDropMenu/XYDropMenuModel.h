//
//  XYDropMenuModel.h
//  DDPay
//
//  Created by htmj on 2019/7/16.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYDropMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYDropMenuModel : NSObject

/** 选中 */
@property (nonatomic, assign) BOOL select;

/** 文本 */
@property (nonatomic, copy) NSString *text;
/** 类型 */
@property (nonatomic, assign) XYDropMenuType type;

/** 筛选视图 */
@property (nonatomic, strong) UIView *screenView;

/** 筛选视图高度 */
@property (nonatomic, assign) CGFloat screenHeight;

@end

NS_ASSUME_NONNULL_END
