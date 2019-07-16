//
//  XYDropMenu.h
//  DDPay
//
//  Created by htmj on 2019/7/12.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 菜单类型 */
typedef NS_ENUM (NSUInteger,XYDropMenuType ) {
    XYDropMenuTypeUpTodown = 0,
    XYDropMenuTypeDownToUp,
};

@interface XYDropMenu : UICollectionView

/** 设置title */
@property (nonatomic, strong) NSArray *titles;
/** 选中title 重设*/
- (void)setResetSeletctTitle:(NSString * _Nullable)resetSeletctTitle;
/** 设置类型 */
- (void)setDropMenuTypes:(NSArray<NSNumber *> * _Nonnull)dropMenuTypes;
/** 设置筛选视图*/
- (void)setDropScreenViews:(NSArray<UIView *> * _Nonnull)dropScreenViews;

/** 背景图 */
@property (nonatomic, strong) UIImage *backgroundImage;
/** 标题菜单标题文字大小 */
@property (nonatomic , strong) UIFont *titleFont;
/** 标题菜单标题正常文字颜色 */
@property (nonatomic , strong) UIColor *titleNormalColor;
/** 标题菜单标题选中文字颜色 */
@property (nonatomic , strong) UIColor *titleSeletedColor;
/** 标题菜单标题正常图片 */
@property (nonatomic , copy) NSString *normalImageName;
/** 标题菜单标题选中图片 */
@property (nonatomic , copy) NSString *seletedImageName;

/** 动画时间 等于0 不开启动画 默认是0 */
@property (nonatomic , assign) NSTimeInterval durationTime;
/** 标题菜单是否记录用户菜单选择 默认是NO */
@property (nonatomic , assign) BOOL recordSeleted;

- (void)show;

/** 关闭菜单 */
- (void)closeMenu;

@end

NS_ASSUME_NONNULL_END
