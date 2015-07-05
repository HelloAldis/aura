//
//  ViewControllerContainer.h
//  AURA
//
//  Created by MacMiniS on 14-9-30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AlbumInfo.h"
#import "CreatorInfo.h"
#import "Photo.h"

@interface ViewControllerContainer : NSObject

+ (void)showLoginViewController;
+ (void)showWPViewController;
+ (void)showCameraViewController;
+ (void)showMyCenter;
+ (void)showUserCenter:(CreatorInfo *)user;
+ (void)showAppSetting;
+ (void)showUserSetting;
+ (void)showFilter:(UIImage *)image;
+ (void)showHome;
+ (void)showAlbumDetail:(AlbumInfo *)alumbInfo;
+ (void)showFollower;
+ (void)showFollowee;
+ (void)showShare:(UIImage *)image;
+ (void)showDiscouvery;
+ (void)showHomeTopAfterShare;
+ (void)showAbout;
+ (void)showLicense;
+ (void)showUsing;
+ (void)showPhotoDetail:(Photo *)photo;
+ (void)showMapWith:(AlbumInfo *)albumInfo;

@end
