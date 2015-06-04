//
//  NSDate+Util.h
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Util)

+ (BOOL)is10DayBeforeNow:(NSDate *)date;
+ (BOOL)is1DayBeforeNow:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)date;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)get10MinAfterNow;
+ (NSString *)getTimeStringFrom:(NSString *)ctime;
+ (NSString *)getDateStringForm:(NSString *)ctime;

@end
