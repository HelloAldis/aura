//
//  CryptoUtil.m
//  AURA
//
//  Created by KindAzrael on 14/10/30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "CryptoUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+Util.h"

#define NEW_LINE_2 @"\n\n"
#define NEW_LINE @"\n"
#define CONTENT_TYPE @"image/jpeg"

@implementation CryptoUtil

+ (NSString *)sha1:(NSData *)data {
  uint8_t digest[CC_SHA1_DIGEST_LENGTH];
  
  CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
  
  NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
  return output;
}

+ (NSString *)signatureMethod:(NSString *)method withDate:(NSString *)date withName:(NSString *)name {
  NSMutableString * signature = [[NSMutableString alloc] initWithString:method];
  [signature appendString:NEW_LINE_2];
//  [signature appendString:CONTENT_TYPE];
  [signature appendString:NEW_LINE];
  [signature appendString:date];
  [signature appendString:NEW_LINE];
  [signature appendString:name];

  return [[[[signature hmacSha1:AccessKeySecret] trim] replaceEmptyToPlus] urlEncode];
//  return [@"GET\n\n\n1141889120\n/oss-example/oss-api.pdf" hmacSha1:AccessKeySecret];
}
/**
 */
@end