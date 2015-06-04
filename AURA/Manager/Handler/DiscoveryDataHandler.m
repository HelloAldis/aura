//
//  DiscoveryDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/4/25.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "DiscoveryDataHandler.h"
#import "DiscoveryResponse.h"
#import "Photo.h"

@implementation DiscoveryDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  
  DiscoveryResponse *resp = (DiscoveryResponse *)baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.photoes.count];
  for (NSDictionary *dict in resp.photoes) {
    [array addObject:[[Photo alloc] initWithData:dict]];
  }
  
  [DataManager setDiscoveryArray:array];
}

@end
