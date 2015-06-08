//
//  ResponseHandler.m
//  AURA
//
//  Created by KindAzrael on 14/10/19.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "ResponseHandler.h"
#import "APIDefines.h"
#import "SVProgressHUD.h"
#import "AllHandler.h"
#import "ErrorMessageManager.h"
#import "AllResponse.h"

@implementation ResponseHandler

+ (void)handleResponse:(BaseResponse *)baseResponse success:(void (^)(void))success failure:(void (^)(void))failure{
  NSString *msg = [ErrorMessageManager handleMessage:[baseResponse resultCode]];
  
  if (msg) {
//    [SVProgressHUD showErrorWithStatus:msg];
    [DataManager setResultCode:baseResponse.resultCode];
    failure();
  } else {
    [ResponseHandler handleSuccessResponse:baseResponse];
    success();
  }
}

+ (void)handleNetworkIssue {
  [SVProgressHUD showErrorWithStatus:@"无网络连接"];
}

+ (void)handleSuccessResponse:(BaseResponse *)baseResponse {
  if ([baseResponse class] == [BaseResponse class]) {
    [BaseDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [LoginResponse class]) {
    [LoginDataHander handleResponse:baseResponse];
  } else if ([baseResponse class] == [EmailRegistResponse class]) {
    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
    [EmailRegistDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [GetAllFolloweeResponse class]) {
    [GetAllFolloweeDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [GetAllFollowerResponse class]) {
    [GetAllFollowerDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [RecommendAlbumResponse class]) {
    [RecommendAlbumDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [CreateAlbumResponse class]) {
    [CreateAlbumDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [CommitResponse class]) {
    [CommitDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [QueryAlbumResponse class]) {
    [QueryAlbumDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [QueryPhotoInfoByFcountResponse class]) {
    [QueryPhotoInfoDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [QueryMostPopPhotoResponse class]) {
    [QueryMostPopPhotoDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [QueryRecentlyInfoResponse class]) {
    [QueryRecentlyInfoDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [DiscoveryResponse class]) {
    [DiscoveryDataHandler handleResponse:baseResponse];
  } else if ([baseResponse class] == [QueryCommentResponse class]) {
    [QueryCommentDataHandler handleResponse:baseResponse];
  }

  [SVProgressHUD dismiss];
}

@end
