//
//  LoginDataHander.m
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "LoginDataHander.h"
#import "LoginResponse.h"

@implementation LoginDataHander

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  LoginResponse *loginResponse = (LoginResponse *)baseResponse;
  [DataManager setToken:[loginResponse token]];
  [DataManager setTokenDate:[NSDate date]];
  [DataManager setMeId:loginResponse.userid];
}

@end
