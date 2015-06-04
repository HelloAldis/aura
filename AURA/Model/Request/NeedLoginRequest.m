//
//  NeedLoginRequest.m
//  AURA
//
//  Created by MacMiniS on 15-3-9.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"
#import "DataManager.h"

@implementation NeedLoginRequest

- (instancetype)init {
  if (self = [super init]) {
    [self setToken:[DataManager token]];
  }
  
  return self;
}

- (void)setToken:(NSString *)token {
  [self.data setObject:token forKey:@"token"];
}

@end
