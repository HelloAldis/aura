//
//  AURA.m
//  AURA
//
//  Created by MacMiniS on 14-9-25.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AURA.h"
#import "APIDefines.h"

@implementation AURA

static UIColor *themeColor = nil;

static UIColor *travelColor = nil;
static UIColor *travelBackgroundColor = nil;
static UIColor *showColor = nil;
static UIColor *showBackgroundColor = nil;
static UIColor *partyColor = nil;
static UIColor *partyBackgroudColor = nil;
static UIColor *sportColor = nil;
static UIColor *sportBackgroundColor = nil;
static UIColor *privateColor = nil;
static UIColor *privateBackgroundColor = nil;

+ (UIColor *)themeColor {
  if (themeColor == nil) {
    themeColor = [UIColor colorWithRed:255.0f/255 green:55.0f/255 blue:16.0f/255 alpha:1.0f];
  }
  
  return themeColor;
}

+ (NSString *)deviceId {
  return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (UIColor *)sportColor {
  if (sportColor == nil) {
    sportColor = [UIColor colorWithRed:225/255.0f green:47/255.0f blue:59/255.0f alpha:1];
  }
  
  return sportColor;
}

+ (UIColor *)sportBackgroundColor {
  if (sportBackgroundColor == nil) {
    sportBackgroundColor = [UIColor colorWithRed:225/255.0f green:47/255.0f blue:59/255.0f alpha:0.2];
  }
  
  return sportBackgroundColor;
}

+ (UIColor *)travelColor {
  if (travelColor == nil) {
    travelColor = [UIColor colorWithRed:242/255.0f green:170/255.0f blue:52/255.0f alpha:1];
  }
  
  return travelColor;
}

+ (UIColor *)travelBackgroundColor {
  if (travelBackgroundColor == nil) {
    travelBackgroundColor = [UIColor colorWithRed:242/255.0f green:170/255.0f blue:52/255.0f alpha:0.2];
  }
  
  return travelBackgroundColor;
}

+ (UIColor *)partyColor {
  if (partyColor == nil) {
    partyColor = [UIColor colorWithRed:79/255.0f green:187/255.0f blue:239/255.0f alpha:1];
  }
  
  return partyColor;
}

+ (UIColor *)partyBackgroundColor {
  if (partyBackgroudColor == nil) {
    partyBackgroudColor = [UIColor colorWithRed:79/255.0f green:187/255.0f blue:239/255.0f alpha:0.2];
  }
  
  return partyBackgroudColor;
}

+ (UIColor *)showColor {
  if (showColor == nil) {
    showColor = [UIColor colorWithRed:99/255.0f green:86/255.0f blue:209/255.0f alpha:1];
  }
  
  return showColor;
}

+ (UIColor *)showBackgroundColor {
  if (showBackgroundColor == nil) {
    showBackgroundColor = [UIColor colorWithRed:99/255.0f green:86/255.0f blue:209/255.0f alpha:0.2];
  }
  
  return showBackgroundColor;
}

+ (UIColor *)privateColor {
  if (privateColor == nil) {
    privateColor = [UIColor colorWithRed:79/255.0f green:180/255.0f blue:127/255.0f alpha:1];
  }
  
  return privateColor;
}

+ (UIColor *)privateBackgroundColor {
  if (privateBackgroundColor == nil) {
    privateBackgroundColor = [UIColor colorWithRed:79/255.0f green:180/255.0f blue:127/255.0f alpha:0.2];
  }
  
  return privateBackgroundColor;
}

+ (UIColor *)getColorByType:(NSString *)type {
  if ([type isEqualToString:PRIVATE]) {
    return [AURA privateColor];
  } else if ([type isEqualToString:SPORTS]) {
    return [AURA sportColor];
  }  else if ([type isEqualToString:TOURISM]) {
    return [AURA travelColor];
  }  else if ([type isEqualToString:PARTY]) {
    return [AURA partyColor];
  }  else if ([type isEqualToString:SHOW]) {
    return [AURA showColor];
  }
  
  return nil;
}

+ (UIColor *)getBackgroundColorByType:(NSString *)type {
  if ([type isEqualToString:PRIVATE]) {
    return [AURA privateBackgroundColor];
  } else if ([type isEqualToString:SPORTS]) {
    return [AURA sportBackgroundColor];
  }  else if ([type isEqualToString:TOURISM]) {
    return [AURA travelBackgroundColor];
  }  else if ([type isEqualToString:PARTY]) {
    return [AURA partyBackgroundColor];
  }  else if ([type isEqualToString:SHOW]) {
    return [AURA showBackgroundColor];
  }
  
  return nil;
}

@end
