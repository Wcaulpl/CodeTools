//
//  UIButton+XYExtension.m
//  XYAutoScrollLabel
//
//  Created by CETzxy on 2018/12/13.
//  Copyright © 2018年 CETzxy. All rights reserved.
//

#import "UIButton+XYExtension.h"

@implementation UIButton (XYExtension)
/*
func hw_locationAdjust(buttonMode: HWButtonMode,
                       spacing: CGFloat) {
    let imageSize = self.imageRect(forContentRect: self.frame)
    let titleFont = self.titleLabel?.font!
    let titleSize = titleLabel?.text?.size(withAttributes: [kCTFontAttributeName as NSAttributedStringKey: titleFont!]) ?? CGSize.zero
    var titleInsets: UIEdgeInsets
    var imageInsets: UIEdgeInsets
    switch (buttonMode){
        case .Top:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Bottom:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Left:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .Right:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
    }
    self.titleEdgeInsets = titleInsets
    self.imageEdgeInsets = imageInsets
}
 */

- (void)xy_locationAdjustWithMode:(XYButtonMode)buttonMode spacing:(CGFloat)spacing {
    CGSize imageSize = [self imageRectForContentRect:self.frame].size;
    UIFont *titleFont = self.titleLabel.font;
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    UIEdgeInsets titleInsets;
    UIEdgeInsets imageInsets;
    switch (buttonMode) {
        case buttonModeTop:
            titleInsets = UIEdgeInsetsMake((imageSize.height + titleSize.height + spacing)/2, -(imageSize.width), 0, 0);
            imageInsets = UIEdgeInsetsMake(-(imageSize.height + titleSize.height + spacing)/2, 0, 0, -titleSize.width);
            break;
        case buttonModeBottom:
            titleInsets = UIEdgeInsetsMake(-(imageSize.height + titleSize.height + spacing)/2,
                                           -(imageSize.width), 0, 0);
            imageInsets = UIEdgeInsetsMake((imageSize.height + titleSize.height + spacing)/2, 0, 0, -titleSize.width);
            break;
        case buttonModeLeft:
            titleInsets = UIEdgeInsetsMake(0, 0, 0, -spacing);
            imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            break;
        case buttonModeRight:
            titleInsets = UIEdgeInsetsMake(0, -(imageSize.width * 2), 0, 0);
            imageInsets = UIEdgeInsetsMake(0, 0, 0, -(titleSize.width * 2 + spacing));
            break;
        default:
            break;
    }
    self.titleEdgeInsets = titleInsets;
    self.imageEdgeInsets = imageInsets;
}

@end
