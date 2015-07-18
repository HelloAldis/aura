//
//  NSString+Util.m
//  AURA
//
//  Created by KindAzrael on 14-10-12.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "NSString+Util.h"
#include <CommonCrypto/CommonHMAC.h>
#import "DataManager.h"

@implementation NSString (Util)

- (BOOL)isEmpty {
  if([self length] == 0) { //string is empty or nil
    return YES;
  }
  
  if([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
    //string is all whitespace
    return YES;
  }
  
  return NO;
}

- (NSString *)hmacSha1:(NSString *)secret {
  NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
  NSData *clearTextData = [self dataUsingEncoding:NSUTF8StringEncoding];
  
  unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], cHMAC);
  
  return [[[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSString *)trim {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)replaceEmptyToPlus {
  return [self stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

- (NSString *)urlEncode {
  return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                             (CFStringRef)self,
                                                             NULL,
                                                             CFSTR("!*'();:@&=+$,/?%#[]~"),
                                                             kCFStringEncodingUTF8));
//  return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
//  return self;
}

- (NSString *)add:(NSInteger)add {
  NSInteger i = [self integerValue];
  return [NSString stringWithFormat:@"%ld", (i + add)];
}

- (NSSet *)tags {
  NSArray *array = [self componentsSeparatedByString:@","];
  NSMutableSet *tags = [[NSMutableSet alloc] initWithCapacity:array.count];
  
  if (array == nil) {
    return tags;
  }
  
  for (NSString *tag in array) {
    if (![@"none" isEqualToString:[tag lowercaseString]] && ![tag isEmpty]) {
      [tags addObject:tag];
    }
  }
  
  return tags;
}

- (BOOL)isMe {
  return [[DataManager meId] isEqualToString:self];
}

- (BOOL)isValidateEmail {
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:self];
}

@end
