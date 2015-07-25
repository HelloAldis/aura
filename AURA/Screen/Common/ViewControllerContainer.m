//
//  ViewControllerContainer.m
//  AURA
//
//  Created by MacMiniS on 14-9-30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "ViewControllerContainer.h"
#import <UIKit/UIKit.h>
#import "UIImage+Util.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "WelcomeAlbumViewController.h"
#import "CameraControlView.h"
#import "UserCenterViewController.h"
#import "AppSettingViewController.h"
#import "UserSettingViewController.h"
#import "FilterViewController.h"
#import "MainToolbar.h"
#import "HomeViewController.h"
#import "AlbumDetailViewController.h"
#import "FollowerViewController.h"
#import "FolloweeViewController.h"
#import "ShareViewController.h"
#import "DiscoveryViewController.h"
#import "DataManager.h"
#import "AboutViewController.h"
#import "UsingViewController.h"
#import "LicenseViewController.h"
#import "PhotoDetailViewController.h"
#import "MapViewController.h"
#import "WelcomeViewController.h"

@interface ViewControllerContainer ()

@property(weak, nonatomic) UIWindow *window;
@property(strong, nonatomic) UINavigationController *mainNav;
@property(strong, nonatomic) UINavigationController *userCenterNav;
@property(strong, nonatomic) UINavigationController *dicoveryNav;

@end

static ViewControllerContainer *container;


@implementation ViewControllerContainer

+ (void)initialize {
  container = [[ViewControllerContainer alloc] init];
}

- (instancetype)init {
  if (self = [super init]) {
    self.window = [AppDelegate sharedInstance].window;
  }
  
  return self;
}

+ (void)showLoginViewController {
  LoginViewController *vc = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
  
  container.window.rootViewController = nav;
  container.mainNav = nil;
  container.userCenterNav = nil;
  container.dicoveryNav = nil;
  [MainToolbar clearToolbar];
}

//显示欢迎
+ (void)showWPViewController {
  if (!container.mainNav) {
    container.mainNav = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] initWithNibName:nil bundle:nil]];
  }
  
  if (![container.mainNav.topViewController isKindOfClass:[WelcomeAlbumViewController class]]) {
    [container.mainNav pushViewController:[[WelcomeAlbumViewController alloc] initWithNibName:nil bundle:nil] animated:NO];
  }

  [container performSelector:@selector(showLater) withObject:nil afterDelay:0.1];
  container.window.rootViewController = container.mainNav;
  [MainToolbar bringToolbarToFront];
}

- (void)showLater {
  [MainToolbar showMainToolbar];
//  [MainToolbar bringToolbarToFront];
}

//显示相机
+ (void)showCameraViewController {
  [MainToolbar hideMainToolbar];
//  [ViewControllerContainer showFilter:[[UIImage imageNamed:@"de.jpg" ] getCenterSquareImage]];
  [CameraControlView startCameraControllerFromViewController:container.window.rootViewController];
}

//显示用户中心
+ (void)showMyCenter {
  if (!container.userCenterNav) {
    UserCenterViewController *center = [[UserCenterViewController alloc] initWithNibName:nil bundle:nil];
    center.userId = [DataManager meId];
    center.showAppSetting = YES;
    container.userCenterNav = [[UINavigationController alloc] initWithRootViewController:center];
  }

  container.window.rootViewController = container.userCenterNav;
  [MainToolbar bringToolbarToFront];
}

+ (void)showUserCenter:(NSString *)userid {
  UserCenterViewController *vc = [[UserCenterViewController alloc] initWithNibName:nil bundle:nil];
  vc.userId = userid;
  vc.showAppSetting = NO;
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [nav pushViewController:vc animated:YES];
}

//显示App设置
+ (void)showAppSetting {
  AppSettingViewController *setting = [[AppSettingViewController alloc] initWithNibName:nil bundle:nil];
  [container.userCenterNav pushViewController:setting animated:YES];
}

//显示用户设置
+ (void)showUserSetting {
  UserSettingViewController *userSetting = [[UserSettingViewController alloc] initWithNibName:nil bundle:nil];
  [container.userCenterNav pushViewController:userSetting animated:YES];
}


//显示滤镜
+ (void)showFilter:(UIImage *)image {
  FilterViewController *filter = [[FilterViewController alloc] initWithNibName:nil bundle:nil];
  filter.orignalImage = image;
  filter.type = TYPE_EDIT_IMAGE;
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [nav pushViewController:filter animated:NO];
}

+ (void)showEditUserImage:(UIImage *)image {
  FilterViewController *filter = [[FilterViewController alloc] initWithNibName:nil bundle:nil];
  filter.orignalImage = image;
  filter.type = TYPE_EDIT_USER;
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [nav pushViewController:filter animated:NO];
}

+ (void)showHome {
  if ([container.mainNav.topViewController isKindOfClass:[WelcomeAlbumViewController class]]) {
    [container.mainNav popViewControllerAnimated:NO];
    container.window.rootViewController = container.mainNav;
  } else {
    container.window.rootViewController = container.mainNav;
  }

  [MainToolbar bringToolbarToFront];
}
   
+ (void)showAlbumDetail:(AlbumInfo *)alumbInfo{
  AlbumDetailViewController *al = [[AlbumDetailViewController alloc] initWithNibName:nil bundle:nil];
  al.albumInfo = alumbInfo;
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [nav pushViewController:al animated:YES];
}

+ (void)showFollower {
  FollowerViewController *fv = [[FollowerViewController alloc] initWithNibName:nil bundle:nil];
  [container.userCenterNav pushViewController:fv animated:YES];
}

+ (void)showFollowee {
  FolloweeViewController *fv = [[FolloweeViewController alloc] initWithNibName:nil bundle:nil];
  [container.userCenterNav pushViewController:fv animated:YES];
}

+ (void)showShare:(UIImage *)image {
  ShareViewController * sv = [[ShareViewController alloc] initWithNibName:nil bundle:nil];
  sv.image = image;
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [nav pushViewController:sv animated:YES];
}

+ (void)showHomeTopAfterShare {
  [container.mainNav popToRootViewControllerAnimated:NO];
  [MainToolbar showMainToolbar];
  [MainToolbar clickFirst];
  [container.mainNav popToRootViewControllerAnimated:NO];
}

+ (void)showDiscouvery {
//  [ViewControllerContainer showShare:[UIImage imageNamed:@"de.jpg"]];
  if (!container.dicoveryNav) {
    DiscoveryViewController *vc = [[DiscoveryViewController alloc] initWithNibName:nil bundle:nil];
    container.dicoveryNav = [[UINavigationController alloc] initWithRootViewController:vc];
  }
  
  container.window.rootViewController = container.dicoveryNav;
  [MainToolbar bringToolbarToFront];
}

+ (void)showAbout {
  AboutViewController *a = [[AboutViewController alloc] initWithNibName:nil bundle:nil];
  [container.userCenterNav pushViewController:a animated:YES];
}

+ (void)showLicense {
  LicenseViewController *a = [[LicenseViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [nav pushViewController:a animated:YES];
}

+ (void)showUsing {
  UsingViewController *a = [[UsingViewController alloc] initWithNibName:nil bundle:nil];
  [container.userCenterNav pushViewController:a animated:YES];
}

+ (void)showPhotoDetail:(id)photo {
  PhotoDetailViewController *p = [[PhotoDetailViewController alloc] initWithNibName:nil bundle:nil];
  p.photo = photo;
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [MainToolbar hideMainToolbar];
  [nav pushViewController:p animated:YES];
}

+ (void)showMapWith:(AlbumInfo *)albumInfo {
  MapViewController *m = [[MapViewController alloc] initWithNibName:nil bundle:nil];
  m.albumInfo = albumInfo;
  UINavigationController *nav = (UINavigationController *)container.window.rootViewController;
  [nav pushViewController:m animated:YES];
}

+ (void)showWelcome {
  WelcomeViewController *w = [[WelcomeViewController alloc] initWithNibName:nil bundle:nil];
  container.window.rootViewController = w;
}

@end
