//
//  BaseResponse.m
//  AURA
//
//  Created by KindAzrael on 14-10-11.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

- (instancetype)initWithData:(id)data {
  if (self = [super init]) {
    _data = data;
  }
  
  return self;
}

- (NSString *)resultCode {
  return [self.data objectForKey:@"result_code"];
}

@end
