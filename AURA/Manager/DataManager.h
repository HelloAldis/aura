//
//  DataManager.h
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataManager : NSObject

+ (void)setResultCode:(NSString *)resultCode;
+ (NSString *)resultCode;
+ (void)setToken:(NSString *)token;
+ (NSString *)token;
+ (void)setTokenDate:(NSDate *)date;
+ (NSDate *)tokenDate;
+ (NSString *)meId;
+ (void)setMeId:(NSString *)meId;
+ (void)setMyNickname:(NSString *)nickname;
+ (NSString *)myNickname;
+ (void)setLatitude:(double)latitude;
+ (double)latitude;
+ (void)setLongitude:(double)longitude;
+ (double)longitude;
+ (UIImage *)image;
+ (void)setImage:(UIImage *)image;
+ (void)setFollowee:(NSMutableArray *)followee;
+ (NSMutableArray *)followee;
+ (void)setFollower:(NSMutableArray *)follower;
+ (NSMutableArray *)follower;
+ (NSString *)latestCreatedAlbumId;
+ (void)setLatestCreatedAlbumId:(NSString *)albumId;
+ (NSString *)latestUploadedImageId;
+ (void)setLatestUploadedImageId:(NSString *)imageId;
+ (void)addToActivityArray:(NSMutableArray *)activityList;
+ (NSMutableArray *)activityArray;
+ (void)setPhotoArray:(NSMutableArray *)photoArray;
+ (NSMutableArray *)photoArray;
+ (void)setMostPopPhotoArray:(NSArray *)array;
+ (NSArray *)mostPopPhotoArray;
+ (void)setRecommendAlbumArray:(NSArray *)array;
+ (NSArray *)recommendAlbumArray;
+ (UIImage *)defaultUserImage;
+ (void)setDiscoveryArray:(NSMutableArray *)array;
+ (NSMutableArray *)discoveryArray;
+ (void)setComments:(NSMutableArray *)array;
+ (NSMutableArray *)comments;

+ (BOOL)isMe:(NSString *)userId;
+ (void)logout;

@end
