//
//  GPSManager.m
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "GPSManager.h"
#import "DataManager.h"

@interface GPSManager ()

@end

static GPSManager *gpsManager;

@implementation GPSManager

- (id)init {
  if ((self = [super init]) != nil) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
  }

  return self;
}

+ (GPSManager *)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{ gpsManager = [[GPSManager alloc] init]; });
  return gpsManager;
}

+ (void)startUpdatingLocation {
  [[GPSManager sharedInstance] startUpdatingLocation];
}

- (void)startUpdatingLocation {
  [self.locationManager requestWhenInUseAuthorization];
  if ([CLLocationManager locationServicesEnabled]) {
      [self.locationManager startUpdatingLocation];
  } else {
    DDLogDebug(@"location service error");
  }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  DDLogDebug(@"longitude %f", [[locations lastObject] coordinate].longitude);
  DDLogDebug(@"latitude %f", [[locations lastObject] coordinate].latitude);

  // Save to user default
  [DataManager setLatitude:[[locations lastObject] coordinate].latitude];
  [DataManager setLongitude:[[locations lastObject] coordinate].longitude];

  [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  DDLogDebug(@"Apple location error: %@", [error localizedDescription]);
}

@end
