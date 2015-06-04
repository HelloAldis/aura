//
//  BaseDataHandler.m
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseDataHandler.h"

@implementation BaseDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [DataManager setResultCode:baseResponse.resultCode];
}

@end
