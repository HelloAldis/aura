//
//  NSString+Util.h
//  AURA
//
//  Created by KindAzrael on 14-10-12.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

- (BOOL)isEmpty;
- (NSString *)hmacSha1:(NSString *)secret;
- (NSString *)trim;
- (NSString *)urlEncode;
- (NSString *)replaceEmptyToPlus;
- (NSString *)add:(NSInteger)add;
- (NSSet *)tags;
- (BOOL)isMe;

@end
