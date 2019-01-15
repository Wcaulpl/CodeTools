//
//  XYAuthID.h
//  CodeToolsDemo
//
//  Created by CETzxy on 2018/12/29.
//  Copyright © 2018年 Wcaulpl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  TouchID/FaceID 状态
 */
typedef NS_ENUM(NSUInteger, XYAuthIDState){
    
    /**
     *  当前设备不支持TouchID/FaceID
     */
    XYAuthIDStateNotSupport = 0,
    /**
     *  TouchID/FaceID 验证成功
     */
    XYAuthIDStateSuccess = 1,
    
    /**
     *  TouchID/FaceID 验证失败
     */
    XYAuthIDStateFail = 2,
    /**
     *  TouchID/FaceID 被用户手动取消
     */
    XYAuthIDStateUserCancel = 3,
    /**
     *  用户不使用TouchID/FaceID,选择手动输入密码
     */
    XYAuthIDStateInputPassword = 4,
    /**
     *  TouchID/FaceID 被系统取消 (如遇到来电,锁屏,按了Home键等)
     */
    XYAuthIDStateSystemCancel = 5,
    /**
     *  TouchID/FaceID 无法启动,因为用户没有设置密码
     */
    XYAuthIDStatePasswordNotSet = 6,
    /**
     *  TouchID/FaceID 无法启动,因为用户没有设置TouchID/FaceID
     */
    XYAuthIDStateTouchIDNotSet = 7,
    /**
     *  TouchID/FaceID 无效
     */
    XYAuthIDStateTouchIDNotAvailable = 8,
    /**
     *  TouchID/FaceID 被锁定(连续多次验证TouchID/FaceID失败,系统需要用户手动输入密码)
     */
    XYAuthIDStateTouchIDLockout = 9,
    /**
     *  当前软件被挂起并取消了授权 (如App进入了后台等)
     */
    XYAuthIDStateAppCancel = 10,
    /**
     *  当前软件被挂起并取消了授权 (LAContext对象无效)
     */
    XYAuthIDStateInvalidContext = 11,
    /**
     *  系统版本不支持TouchID/FaceID (必须高于iOS 8.0才能使用)
     */
    XYAuthIDStateVersionNotSupport = 12
};

#define iPhoneXSeries (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))

@interface XYAuthID : NSObject

+ (void)xy_showAuthIDFinished:(void (^)(XYAuthIDState state, NSError *error))block;

@end

NS_ASSUME_NONNULL_END
