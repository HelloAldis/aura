//
//  SearchNicknameDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/6/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "SearchNicknameDataHandler.h"
#import "SearchNicknameResponse.h"

@implementation SearchNicknameDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  
  SearchNicknameResponse *resp = (SearchNicknameResponse *)baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
  if (resp.userinfo.userId) {
    [array addObject:resp.userinfo];
  }
  [DataManager setSearchUserArray:array];
}

@end
