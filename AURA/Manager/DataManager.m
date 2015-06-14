//
//  DataManager.m
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#define SET_OBJECT(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define SET_DOUBLE(value, key) [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key]
#define GET_DOUBLE(key) [[NSUserDefaults standardUserDefaults] doubleForKey:key]

#import "DataManager.h"
#import "AlbumInfo.h"
#import "Photo.h"

@interface DataManager ()

@property(strong, nonatomic) NSString *resultCode;
@property(strong, nonatomic) UIImage *image;
@property(strong, nonatomic) NSMutableArray *followee;
@property(strong, nonatomic) NSMutableArray *follower;
@property(strong, nonatomic) NSString *latestCreatedAlbumId;
@property(strong, nonatomic) NSString *latestUploadedImageId;
@property(strong, nonatomic) NSString *latestCommitPhotoId;
@property(strong, nonatomic) NSMutableArray *activityArray;
@property(strong, nonatomic) NSMutableArray *photoArray;
@property(strong, nonatomic) NSArray *mostPopPhotoArray;
@property(strong, nonatomic) NSArray *recommendAlbumArray;
@property(strong, nonatomic) NSMutableArray *discoveryArray;
@property(strong, nonatomic) NSMutableArray *comments;
@property(strong, nonatomic) NSMutableArray *searchAlbumArray;
@property(strong, nonatomic) NSMutableArray *searchUserArray;

@end

static DataManager *dataManager;

@implementation DataManager

+ (void)initialize {
  if(!dataManager) {
    dataManager = [[DataManager alloc] init];
  }
}

+ (void)setResultCode:(NSString *)resultCode {
  dataManager.resultCode = resultCode;
}

+ (NSString *)resultCode {
  return dataManager.resultCode;
}

+ (void)setToken:(NSString *)token {
  SET_OBJECT(token, @"token");
}

+ (NSString *)token {
#ifdef ADEBUG
  return @"123";
#else
  return GET_OBJECT(@"token");
#endif
}

+ (void)setMeId:(NSString *)meId {
  SET_OBJECT(meId, @"meId");
}

+ (NSString *)meId {
  return GET_OBJECT(@"meId");
}

+ (void)setMyNickname:(NSString *)nickname {
  SET_OBJECT(nickname, @"nickname");
}

+ (NSString *)myNickname {
  return GET_OBJECT(@"nickname");
}

+ (void)setTokenDate:(NSDate *)date {
  SET_OBJECT(date, @"tokendate");
}

+ (NSDate *)tokenDate {
  return GET_OBJECT(@"tokendate");
}

+ (void)setLatitude:(double) latitude{
  SET_DOUBLE(latitude, @"latitude");
}

+ (double)latitude {
//  return 30.465293;
  return GET_DOUBLE(@"latitude");
}

+ (void)setLongitude:(double)longitude {
  SET_DOUBLE(longitude, @"longitude");
}

+ (double)longitude {
//  return 114.393719;
  return GET_DOUBLE(@"longitude");
}

+ (UIImage *)image {
  return dataManager.image;
}

+ (void)setImage:(UIImage *)image {
  dataManager.image = image;
}

+ (void)setFollowee:(NSMutableArray *)followee {
  dataManager.followee = followee;
}

+ (NSMutableArray *)followee {
  return dataManager.followee;
}

+ (void)setFollower:(NSMutableArray *)follower {
  dataManager.follower = follower;
}

+ (NSMutableArray *)follower {
  return dataManager.follower;
}

+ (NSString *)latestCreatedAlbumId {
  return  dataManager.latestCreatedAlbumId;
}

+ (void)setLatestCreatedAlbumId:(NSString *)albumId {
  dataManager.latestCreatedAlbumId = albumId;
}

+ (NSString *)latestUploadedImageId {
  return dataManager.latestUploadedImageId;
}

+ (void)setLatestUploadedImageId:(NSString *)imageId {
  dataManager.latestUploadedImageId = imageId;
}

+ (NSString *)latestCommitPhotoId {
  return dataManager.latestCommitPhotoId;
}

+ (void)setLatestCommitPhotoId:(NSString *)photoId {
  dataManager.latestCommitPhotoId = photoId;
}

+ (void)addToActivityArray:(NSMutableArray *)activityList {
  dataManager.activityArray = activityList;
}

+ (NSMutableArray *)activityArray {
#ifdef ADEBUG
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  Photo *a = [[Photo alloc] initWithData:@{@"albumid":@"123", @"type":@"private"}];
  [arr addObject:a];
  return arr;
#else
  return dataManager.activityArray;
#endif
}

+ (void)setPhotoArray:(NSMutableArray *)photoArray {
  dataManager.photoArray = photoArray;
}

+ (NSMutableArray *)photoArray {
  return dataManager.photoArray;
}

+ (void)setMostPopPhotoArray:(NSArray *)array {
  dataManager.mostPopPhotoArray = array;
}

+ (NSArray *)mostPopPhotoArray {
  return dataManager.mostPopPhotoArray;
}

+ (void)setRecommendAlbumArray:(NSArray *)array {
  dataManager.recommendAlbumArray = array;
}

+ (NSArray *)recommendAlbumArray {
#ifdef ADEBUG
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  AlbumInfo *a = [[AlbumInfo alloc] initWithData:@{@"type":@"private"}];
  [arr addObject:a];
  return arr;
#else
  return dataManager.recommendAlbumArray;
#endif
}

+ (UIImage *)defaultUserImage {
  return [UIImage imageNamed:@"11账户设置_pic_男"];
}

+ (void)setDiscoveryArray:(NSMutableArray *)array {
  dataManager.discoveryArray = array;
}

+ (NSMutableArray *)discoveryArray {
  return dataManager.discoveryArray;
}

+ (void)setComments:(NSMutableArray *)array {
  dataManager.comments = array;
}

+ (NSMutableArray *)comments {
  return  dataManager.comments;
}

+ (BOOL)isMe:(NSString *)userId {
  return [[DataManager meId] isEqualToString:userId];
}

+ (void)logout {
  [DataManager setMeId:nil];
  [DataManager setToken:nil];
  [DataManager setTokenDate:nil];
  [DataManager setMyNickname:nil];
}

+ (void)setSearchAlbumArray:(NSMutableArray *)array {
  dataManager.searchAlbumArray = array;
}

+ (NSMutableArray *)searchAlbumArray {
  return dataManager.searchAlbumArray;
}

+ (void)setSearchUserArray:(NSMutableArray *)array {
  dataManager.searchUserArray = array;
}

+ (NSMutableArray *)searchUserArray {
  return dataManager.searchUserArray;
}

@end
