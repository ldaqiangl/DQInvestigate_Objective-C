//
//  YYAES128Util.m
//  Kangs100Vip
//
//  Created by 06-kangs100 on 15/7/30.
//  Copyright (c) 2015年 06-kangs100. All rights reserved.
//

#import "YYAES128Util.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@implementation YYAES128Util



+(NSData *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return resultData;
    }
    free(buffer);
    return nil;
}




+(NSData *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key
{
    //加密算法：kCCAlgorithmAES128
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    NSString *encryptStr = [GTMBase64 stringByEncodingData:encryptBytes];
//    //NSLog(@"%@",encryptStr);
    
    //size_t  是操作符sizeof返回的结果类型
    //解码base64
    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, //加密/解密
                                          kCCAlgorithmAES128,   //加密（根据哪个标准）
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],  //秘钥
                                          kCCBlockSizeAES128, //密钥长度
                                          NULL, //可选择的初始化矢量
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);
    return nil;
    
}

#pragma maek -- 保留

//byte转十六进制
/**
 Byte *bytes = (Byte *)[resultData bytes];
 
 id newHexString = [[NSString alloc]init];
 NSString *hexStr = @"";
 for (int i = 0; i<resultData.length; i++) {
 newHexString = [NSString stringWithFormat:@"%x",bytes[i]&0xff];
 if ([newHexString length] == 1) {
 hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexString];
 }else{
 hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexString];
 }
 }
 return hexStr;
 **/

//十六进制转Byte
/**
 +(NSData *)stringToHexData:(NSString *)encryptText
 {
 int len = [encryptText length]/2;
 unsigned char *buf = malloc(len);
 unsigned char *whole_byte = buf;
 char byte_chars[3] = {'\0','\0','\0'};
 int i;
 for (i = 0; i<len; i++) {
 byte_chars[0] = [encryptText characterAtIndex:i*2];
 byte_chars[1] = [encryptText characterAtIndex:i*2+1];
 *whole_byte = strtol(byte_chars, NULL, 16);
 whole_byte++;
 }
 NSData *data = [NSData dataWithBytes:buf length:len];
 free(buf);
 return data;
 }
 **/
@end
