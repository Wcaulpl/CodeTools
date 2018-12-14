//
//  NSString+Regular.h
//  XYAutoScrollLabel
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 CETzxy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Regular)

#pragma 正则匹配邮箱号
- (BOOL)checkMail;

#pragma 正则匹配手机号
- (BOOL)checkTelNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
- (BOOL)checkPassword;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName;

#pragma 正则匹配用户身份证号15或18位
- (BOOL)checkUserIdCard;

#pragma 正则匹员工号,12位的数字
- (BOOL)checkEmployeeNumber;

#pragma 正则匹配URL
- (BOOL)checkURL;

#pragma 正则匹配昵称
- (BOOL) checkNickname;

#pragma 正则匹配以C开头的18位字符
- (BOOL)checkCtooNumberTo18;

#pragma 正则匹配以C开头字符
- (BOOL)checkCtooNumber;

#pragma 正则匹配银行卡号是否正确
- (BOOL)checkBankNumber;

#pragma 正则匹配17位车架号
- (BOOL)checkCheJiaNumber;

#pragma 正则只能输入数字和字母
- (BOOL)checkTeshuZifuNumber;

#pragma 车牌号验证
- (BOOL)checkCarNumber;

@end

NS_ASSUME_NONNULL_END
