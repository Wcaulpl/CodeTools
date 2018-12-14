//
//  NSString+Encrypt.h
//  XYAutoScrollLabel
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 CETzxy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encrypt)

#pragma mark -------------Base64加密------------
/*
 * Base64编码：
 */
- (NSString *)base64encode;

/*
 * Base64解码：
 */
- (NSString *)base64dencode;

#pragma mark -------------MD5加密------------
/*
 * MD5加密是不可逆：
 */
// 32位 小写
- (NSString *)md5ForLower32Bate;

// 32位 大写
- (NSString *)md5ForUpper32Bate;

// 16位 大写
- (NSString *)md5ForUpper16Bate;

// 16位 小写
- (NSString *)md5ForLower16Bate;

#pragma mark -------------AES256加密解密------------
/*
 * AES256加密：
 */
- (NSString *)aes256Encrypt;

/*
 * AES256解码：
 */
- (NSString *)aes256Decrypt;


#pragma mark -------------DES3加密解密------------
/*
 * DES3加密：
 */
- (NSString*)des3Encrypt;

/*
 * DES3解码：
 */
- (NSString*)des3Decrypt;

@end

NS_ASSUME_NONNULL_END
