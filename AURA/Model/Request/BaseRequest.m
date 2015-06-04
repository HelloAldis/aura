//
//  BaseRequest.m
//  AURA
//
//  Created by KindAzrael on 14-10-11.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (instancetype)init {
  if (self = [super init]) {
    _data = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

@end
