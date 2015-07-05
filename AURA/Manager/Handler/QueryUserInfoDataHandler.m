//
//  QueryUserInfoDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryUserInfoDataHandler.h"
#import "QueryUserInfoResponse.h"
#import "UserInfo.h"
#import "FollowUser.h"

@implementation QueryUserInfoDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  QueryUserInfoResponse *resp = (QueryUserInfoResponse *)baseResponse;
  UserInfo *userInfo = [[UserInfo alloc] init];
  
  NSMutableArray *follower = [[NSMutableArray alloc] initWithCapacity:[resp follower].count];
  NSMutableArray *followee = [[NSMutableArray alloc] initWithCapacity:[resp followee].count];
  
  for (id data in [resp follower]) {
    [follower addObject:[[FollowUser alloc] initWithData:data]];
  }
  
  for (id data in [resp followee]) {
    [followee addObject:[[FollowUser alloc] initWithData:data]];
  }
  
  userInfo.followee = followee;
  userInfo.follower = follower;
  userInfo.sign = [resp sign];
  
  [DataManager setUserInfo:userInfo];
}

@end
