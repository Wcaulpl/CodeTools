//
//  XYDropMenuTitleItem.h
//  DDPay
//
//  Created by htmj on 2019/7/12.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 筛选菜单 菜单标题cell
 */
@interface XYDropMenuTitleItem : UICollectionViewCell

- (void)setItemText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font imageName:(NSString *)imageName maxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
