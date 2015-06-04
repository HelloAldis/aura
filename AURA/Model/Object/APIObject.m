//
//  APIObject.m
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "APIObject.h"


@implementation APIObject

- (instancetype)initWithData:(id)data {
  if (self = [super init]) {
    _data = [[NSMutableDictionary alloc] initWithDictionary:data];
  }
  
  return self;
}


@end
