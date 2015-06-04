//
//  NSData+Util.m
//  AURA
//
//  Created by MacMiniS on 14-10-31.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "NSData+Util.h"
#import "CryptoUtil.h"

@implementation NSData (Util)

- (NSString *)sha1 {
  return [CryptoUtil sha1:self];
}

@end
