//
//  NSDate+Util.m
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#define TEN_DAY 864000
#define ONE_DAY 86400
#define ONE_MIN 60
#define ONE_HOUR 3600
#define DATE_FORMAT @"yyyy.MM.dd"
#define FORMAT_HHMM @"HH:mm"
#define FORMAT_MMDD @"MM-dd"

#import "NSDate+Util.h"

@implementation NSDate (Util)

+ (BOOL)is10DayBeforeNow:(NSDate *)date {
  if (!date) {
    return YES;
  }
  
  date = [date dateByAddingTimeInterval:TEN_DAY];
  NSDate *now = [NSDate date];
  return [now compare:date] == NSOrderedDescending;
}

+ (BOOL)is1DayBeforeNow:(NSDate *)date {
  if (!date) {
    return YES;
  }
  
  date = [date dateByAddingTimeInterval:ONE_DAY];
  NSDate *now = [NSDate date];
  return [now compare:date] == NSOrderedDescending;
}

+ (NSDate *)dateFromString:(NSString *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:DATE_FORMAT];
  return [formatter dateFromString:date];
}

+ (NSDate *)dateFromYYYYMMDDHHMMSS:(NSString *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  return [formatter dateFromString:date];
}

+ (NSString *)stringFromDate:(NSDate *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:DATE_FORMAT];
  return [formatter stringFromDate:date];
}

+ (NSString *)get10MinAfterNow {
  NSDate *now = [NSDate date];
  now = [now dateByAddingTimeInterval:36000];
  return [NSString stringWithFormat:@"%.f", [now timeIntervalSince1970]];
}

+ (NSString *)getHHSS:(NSDate *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:FORMAT_HHMM];
  return [formatter stringFromDate:date];
}

+ (NSString *)getMMDD:(NSDate *)date {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:FORMAT_MMDD];
  return [formatter stringFromDate:date];
}

+ (NSString *)getTimeStringFrom:(NSString *)ctime {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *cDate = [formatter dateFromString:ctime];
  NSDate *now = [NSDate date];
  
  NSTimeInterval diff = [now timeIntervalSinceReferenceDate] - [cDate timeIntervalSinceReferenceDate];
  if (diff < 5*60) {
    return @"刚刚";
  } else if (diff >= 5*ONE_MIN && diff < ONE_HOUR) {
    NSInteger i = diff / ONE_MIN;
    return [NSString stringWithFormat:@"%ld分钟前", (long)i];
  } else if (diff >= ONE_HOUR && diff < ONE_DAY) {
    NSInteger i = diff / ONE_HOUR;
    return [NSString stringWithFormat:@"%ld小时前", (long)i];
  } else if (diff >= ONE_DAY && diff < 2*ONE_DAY) {
    NSString *str = [NSDate getHHSS:cDate];
    return [NSString stringWithFormat:@"昨天%@", str];
  } else if (diff >= 2*ONE_DAY) {
    return [NSDate getMMDD:cDate];
  } else {
    return nil;
  }
}

+ (NSString *)getDateStringForm:(NSString *)ctime {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *cDate = [formatter dateFromString:ctime];
  
  return [NSDate getMMDD:cDate];
}

@end
