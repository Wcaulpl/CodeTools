//
//  NSString+XYRegex.h
//  XYAutoScrollLabel
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 CETzxy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XYRegex)

#pragma mark  正则匹配用户密码6-18位数字和字母组合
- (BOOL)checkPassword;

#pragma mark  正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName;

#pragma mark  正则匹员工号,12位的数字
- (BOOL)checkEmployeeNumber;

#pragma mark  正则匹配昵称
- (BOOL)checkNickname;

#pragma mark  正则匹配以C开头的18位字符
- (BOOL)checkCtooNumberTo18;

#pragma mark  正则匹配以C开头字符
- (BOOL)checkCtooNumber;

#pragma mark  正则只能输入数字和字母
- (BOOL)checkTeshuZifuNumber;

// ------------------------------------------------------------------

#pragma mark  邮箱验证
- (BOOL)isValidEmail;

#pragma mark  手机号码验证
- (BOOL)isValidPhoneNum;

#pragma mark  车牌号验证
- (BOOL)isValidCarNo;

#pragma 正则匹配银行卡号是否正确
- (BOOL)isValidBankNum;

#pragma mark  正则匹配17位车架号
- (BOOL)isValidCheJiaNum;

#pragma mark  网址验证
- (BOOL)isValidUrl;

#pragma mark  邮政编码
- (BOOL)isValidPostalcode;

#pragma mark  工商税号
- (BOOL)isValidTaxNo;

#pragma mark  纯汉字
- (BOOL)isValidChinese;

#pragma mark  是否符合IP格式，xxx.xxx.xxx.xxx
- (BOOL)isValidIP;

#pragma mark  身份证验证
- (BOOL)isValidIdCardNum;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingBlank;

/** 去掉html格式 */
- (NSString *)removeHtmlFormat;

@end

NS_ASSUME_NONNULL_END
