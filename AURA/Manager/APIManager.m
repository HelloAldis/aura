//
//  APIManager.m
//  AURA
//
//  Created by KindAzrael on 14-10-9.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "APIManager.h"
#import "AURA.h"
#import "ResponseHandler.h"
#import "SVProgressHUD.h"
#import "UIImage+Util.h"
#import "NSData+Util.h"
#import "NSDate+Util.h"
#import "CryptoUtil.h"
#import "DataManager.h"
#import "AllResponse.h"

#ifdef ADEBUG
#define AURA_URL @"http://127.0.0.1"
#define ALI_URL @"http://127.0.0.1"
#else
#define AURA_URL @"http://182.92.166.245/"
#define ALI_URL @"http://aura.oss.aliyuncs.com/"
#endif


@interface APIManager ()


@end

static AFHTTPRequestOperationManager *_manager;
static AFHTTPRequestOperationManager *_oos;

@implementation APIManager

+ (void)initialize {
  _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:AURA_URL]];
  _manager.requestSerializer = [AFJSONRequestSerializer serializer];
  [_manager.requestSerializer setValue:[AURA deviceId] forHTTPHeaderField:@"deviceId"];
  
  _oos = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:ALI_URL]];
  _oos.requestSerializer = [AFHTTPRequestSerializer serializer];
  _oos.responseSerializer = [AFHTTPResponseSerializer serializer];
}


+ (void)login:(LoginRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [SVProgressHUD show];
  [_manager POST:@"/aura/login"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[LoginResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)emailRegist:(RegistRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure{
  [SVProgressHUD show];
  [_manager POST:@"/aura/emailRegist"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[EmailRegistResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)confirm:(ConfirmRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure{
  [_manager POST:@"/aura/confrim"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           BaseResponse *baseResponse = [[BaseResponse alloc] initWithData:responseObject];
           if ([baseResponse.resultCode integerValue] == CODE_OK) {
             success();
           } else {
             failure();
           }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)refreshToken:(ConfirmRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure{
  [_manager POST:@"/aura/refreshToken"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {success();}
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {failure();}];
}

+ (void)checkNickName:(CheckNickNameRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure{
  [_manager POST:@"/aura/checkNickName"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           CheckNickNameResponse *response = [[CheckNickNameResponse alloc] initWithData:responseObject];
           if ([response.resultCode integerValue] == CODE_OK && !response.exist) {
             success();
           } else {
             failure();
           }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)createAlbum:(CreateAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [DataManager setLatestCreatedAlbumId:nil];
  
  [_manager POST:@"/aura/createAlbum"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           CreateAlbumResponse *response = [[CreateAlbumResponse alloc] initWithData:responseObject];
           [ResponseHandler handleResponse:response success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)recommendAlbum:(RecommendAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/recommendAlbum"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[RecommendAlbumResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)uploadImage:(UIImage *)image success:(void (^)(void))success failure:(void (^)(void))failure {
  [DataManager setLatestUploadedImageId:nil];
//  image = [UIImage imageNamed:@"1.jpeg"];
  NSData *data = [image data];
  DDLogDebug(@"size %lu", (unsigned long)data.length);
  
  NSString *sha1 = [data sha1];
  NSString *date = [NSDate get10MinAfterNow];
  NSString *signature = [CryptoUtil signatureMethod:PUT_METHOD withDate:date withName:[NSString stringWithFormat:@"/aura/%@", sha1]];
  NSString *url = [NSString stringWithFormat:@"/%@?OSSAccessKeyId=%@&Expires=%@&Signature=%@", sha1, AccessID, date, signature];
  
  NSMutableURLRequest *request = [_oos.requestSerializer requestWithMethod:PUT_METHOD URLString:[[NSURL URLWithString:url relativeToURL:_oos.baseURL] absoluteString] parameters:nil error:nil];
  [request setHTTPBody:data];
  AFHTTPRequestOperation *operation = [_oos HTTPRequestOperationWithRequest:request
                                                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                      DDLogDebug(@"%@", responseObject);
                                                                      [DataManager setLatestUploadedImageId:sha1];
                                                                      success();
                                                                    }
                                                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                      DDLogDebug(@"%@", error);
                                                                      failure();
                                                                      [ResponseHandler handleNetworkIssue];
                                                                    }];
  [_oos.operationQueue addOperation:operation];
}

+ (void)downImage:(NSString *)sha1 success:(void (^)(void))success failure:(void (^)(void))failure {
  NSString *date = [NSDate get10MinAfterNow];
  NSString *signature = [CryptoUtil signatureMethod:GET_METHOD withDate:date withName:[NSString stringWithFormat:@"/aura/%@", sha1]];
  NSString *url = [NSString stringWithFormat:@"/%@?OSSAccessKeyId=%@&Expires=%@&Signature=%@", sha1, AccessID, date, signature];
  
  [SVProgressHUD show];
  [_oos GET:url
 parameters:nil
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      [DataManager setImage:[UIImage imageWithData:responseObject]];
      [SVProgressHUD dismiss];
      success();
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      [SVProgressHUD dismiss];
    }];
}

+ (void)commit:(CommitRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/commit"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           success();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)follow:(FollowRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/follow"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           success();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)getAllFollowee:(GetAllFolloweeRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/getAllFollowee"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[GetAllFolloweeResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)getAllFollower:(GetAllFollowerRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/getAllFollower"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [ResponseHandler handleResponse:[[GetAllFollowerResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)queryAlbum:(QueryAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/queryAlbum"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[QueryAlbumResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)queryPhotoInfoByCtime:(QueryPhotoInfoByCtimeRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [DataManager setPhotoArray:nil];
  [_manager POST:@"/aura/queryPhotoInfoByCtime"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[QueryPhotoInfoByFcountResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)queryPhotoInfoByFcount:(QueryPhotoInfoByFcountRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/queryPhotoInfoByFcount"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[QueryPhotoInfoByFcountResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)favourite:(FavouriteRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/favourite"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           success();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)delFavourite:(DelFavouriteRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/delFavourite"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           DDLogDebug(@"%@", responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)queryMostPopPhoto:(QueryMostPopPhotoRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/queryMostPopPhoto"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[QueryMostPopPhotoResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)queryRecentlyInfo:(QueryRecentlyInfoRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/queryRecentlyInfo"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[QueryRecentlyInfoResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)deleteAlbum:(DeleteAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/deleteAlbum"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           success();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)deletePhoto:(DeletePhotoRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/deletePhoto"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           success();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)discoveryAll:(void (^)(void))success failure:(void (^)(void))failure {
  QueryMostPopPhotoRequest *request = [[QueryMostPopPhotoRequest alloc] init];
  [request setsize:1000];
  
  [_manager POST:@"/aura/queryMostPopPhoto"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[DiscoveryResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)discoveryCity:(void (^)(void))success failure:(void (^)(void))failure {
  RecommendPhotoesByCityRequest *request = [[RecommendPhotoesByCityRequest alloc] init];
  [request setCity:@"武汉市"];
  [request setCursor:0];
  [request setSize:1000];
  
  [_manager POST:@"/aura/recommendPhotoesByCity"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[DiscoveryResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)discoveryNearSuccess:(void (^)(void))success failure:(void (^)(void))failure {
  [APIManager discoveryCity:success failure:failure];
}

+ (void)addComment:(AddCommentRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [_manager POST:@"/aura/addComment"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           success();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

+ (void)queryComment:(QueryCommentRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure {
  [DataManager setComments:nil];
  [_manager POST:@"/aura/queryComment"
      parameters:request.data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [ResponseHandler handleResponse:[[QueryCommentResponse alloc] initWithData:responseObject] success:success failure:failure];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           failure();
           [ResponseHandler handleNetworkIssue];
         }];
}

@end
