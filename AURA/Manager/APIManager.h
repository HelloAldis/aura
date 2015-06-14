//
//  APIManager.h
//  AURA
//
//  Created by KindAzrael on 14-10-9.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "APIDefines.h"
#import "AllRequest.h"

@interface APIManager : NSObject

+ (void)login:(LoginRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)emailRegist:(RegistRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)confirm:(ConfirmRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)refreshToken:(ConfirmRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)checkNickName:(CheckNickNameRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)createAlbum:(CreateAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)recommendAlbum:(RecommendAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)uploadImage:(UIImage *)image success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)downImage:(NSString *)sha1 success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)commit:(CommitRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)follow:(FollowRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)getAllFollowee:(GetAllFolloweeRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)getAllFollower:(GetAllFollowerRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)queryAlbum:(QueryAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)queryPhotoInfoByCtime:(QueryPhotoInfoByCtimeRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)queryPhotoInfoByFcount:(QueryPhotoInfoByFcountRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)favourite:(FavouriteRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)delFavourite:(DelFavouriteRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)queryMostPopPhoto:(QueryMostPopPhotoRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)queryRecentlyInfo:(QueryRecentlyInfoRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)deleteAlbum:(DeleteAlbumRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)deletePhoto:(DeletePhotoRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)discoveryNearSuccess:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)discoveryCity:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)discoveryAll:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)addComment:(AddCommentRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)queryComment:(QueryCommentRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)searchAlbumByName:(SearchAlbumByNameRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)searchNickname:(SearchNicknameRequest *)request success:(void (^)(void))success failure:(void (^)(void))failure;

@end
