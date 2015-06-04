//
//  GetAllFolloweeDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "GetAllFolloweeDataHandler.h"
#import "GetAllFolloweeResponse.h"
#import "FollowUser.h"

@implementation GetAllFolloweeDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  GetAllFolloweeResponse *resp = (GetAllFolloweeResponse *)baseResponse;
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[resp followee].count];
  for (id data in [resp followee]) {
    [array addObject:[[FollowUser alloc] initWithData:data]];
  }
  
  [DataManager setFollowee:array];
}

@end
