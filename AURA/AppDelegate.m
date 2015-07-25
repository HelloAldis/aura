//
//  AppDelegate.m
//  AURA
//
//  Created by MacMiniS on 14-9-24.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ViewControllerContainer.h"
#import "AFNetworkActivityLogger.h"
#import "UIKit+AFNetworking.h"
#import "SVProgressHUD.h"
#import "AURA.h"
#import "DataManager.h"
#import "NSDate+Util.h"
#import "SDWebImageManager.h"
#import "GPSManager.h"
#import "LogFormatter.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self initLog];
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  [SVProgressHUD setForegroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]];
  [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
  [self initNavStyle];
  [self initImageCache];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  if ([DataManager isShowWelcomeAlready]) {
    if ([NSDate is10DayBeforeNow:[DataManager tokenDate]]) {
      [ViewControllerContainer showLoginViewController];
    } else {
      [ViewControllerContainer showWPViewController];
    }
  } else {
    [ViewControllerContainer showWelcome];
  }

  [self.window makeKeyAndVisible];
  
  [DataManager setShowWelcomeAlready];
  
  return YES;
}

- (void)initNavStyle {
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  [[UINavigationBar appearance] setBarTintColor:[AURA themeColor]];
  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  [[UINavigationBar appearance] setTranslucent:NO];
  [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)initImageCache {  
  SDWebImageManager.sharedManager.cacheKeyFilter = ^(NSURL *url) {
    return [url.path substringFromIndex:1];
  };
}

- (void)initLog {
  LogFormatter *formatter = [[LogFormatter alloc] init];
  
  [[DDASLLogger sharedInstance] setLogFormatter:formatter];
  [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
  
  DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
  fileLogger.rollingFrequency = 5*60;
  fileLogger.logFileManager.maximumNumberOfLogFiles = 4;
  [fileLogger setLogFormatter:formatter];
  
  [DDLog addLogger:[DDASLLogger sharedInstance]];
  [DDLog addLogger:[DDTTYLogger sharedInstance]];
  [DDLog addLogger:fileLogger];
  
  [[AFNetworkActivityLogger sharedLogger] startLogging];
  [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  [GPSManager startUpdatingLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)sharedInstance {
  return [UIApplication sharedApplication].delegate;
}

@end
