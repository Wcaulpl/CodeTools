//
//  XYDropMenuTitleItem.m
//  DDPay
//
//  Created by htmj on 2019/7/12.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "XYDropMenuTitleItem.h"
#import "UILabel+XYDrop.h"

@interface XYDropMenuTitleItem()
@property (nonatomic , strong) UILabel *label;
@end
@implementation XYDropMenuTitleItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 0, 80, 44);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 1;
    [self addSubview:self.label=label];
}

- (void)setItemText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font imageName:(NSString *)imageName maxWidth:(CGFloat)maxWidth {
    self.label.textColor = textColor;
    [self.label creatRichTextWithText:text frame:CGRectMake(0, 0, 40, 44) font:[UIFont systemFontOfSize:16] imageName:imageName maxWidth:maxWidth];
}

@end
