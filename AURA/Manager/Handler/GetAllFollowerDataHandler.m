//
//  GetAllFolowerDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "GetAllFollowerDataHandler.h"
#import "FollowUser.h"
#import "GetAllFollowerResponse.h"

@implementation GetAllFollowerDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  GetAllFollowerResponse *resp = (GetAllFollowerResponse *)baseResponse;
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[resp follower].count];
  for (id data in [resp follower]) {
    [array addObject:[[FollowUser alloc] initWithData:data]];
  }
  
  [DataManager userInfo].follower = array;
}

@end
