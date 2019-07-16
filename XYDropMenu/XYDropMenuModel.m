//
//  XYDropMenuModel.m
//  DDPay
//
//  Created by htmj on 2019/7/16.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "XYDropMenuModel.h"

@implementation XYDropMenuModel

- (void)setScreenView:(UIView *)screenView {
    _screenView = screenView;
    self.screenHeight = CGRectGetHeight(screenView.frame);
}

@end
