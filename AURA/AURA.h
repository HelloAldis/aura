//
//  AURA.h
//  AURA
//
//  Created by MacMiniS on 14-9-25.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AURA : NSObject

+ (UIColor *)themeColor;
+ (NSString *)deviceId;
+ (UIColor *)sportColor;
+ (UIColor *)sportBackgroundColor;
+ (UIColor *)travelColor;
+ (UIColor *)travelBackgroundColor;
+ (UIColor *)partyColor;
+ (UIColor *)partyBackgroundColor;
+ (UIColor *)showColor;
+ (UIColor *)showBackgroundColor;
+ (UIColor *)privateColor;
+ (UIColor *)privateBackgroundColor;
+ (UIColor *)getColorByType:(NSString *)type;
+ (UIColor *)getBackgroundColorByType:(NSString *)type;

@end
