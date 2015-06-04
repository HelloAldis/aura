//
//  QueryRecentlyInfoDataHandler.m
//  AURA
//
//  Created by MacMiniS on 15-4-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryRecentlyInfoDataHandler.h"
#import "QueryRecentlyInfoResponse.h"
#import "Photo.h"

@implementation QueryRecentlyInfoDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];

  QueryRecentlyInfoResponse *resp = (QueryRecentlyInfoResponse *) baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.photoes.count];
  for (NSDictionary *dict in resp.photoes) {
    if ([dict isKindOfClass:[NSArray class]]) {
      NSArray *a = (NSArray *)dict;
      for (NSDictionary *d in a) {
        [array addObject:[[Photo alloc] initWithData:d]];
      }
    } else {
      [array addObject:[[Photo alloc] initWithData:dict]];
    }
  }
  
  [DataManager addToActivityArray:array];
}

@end
