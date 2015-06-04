//
//  LogFormatter.m
//  TestCocoaLumberjack
//
//  Created by MacMiniS on 5/22/14.
//  Copyright (c) 2014 Aldis. All rights reserved.
//

#import "LogFormatter.h"

#define DATE_FORMAT @"yyyy/MM/dd HH:mm:ss:SSS"
#define LOG_FORMAT @"%@ %@ [%s.%s] flag:%d context:%d line:%d treadId:%d name:%@ queueLabel:%s message:%@"

@interface LogFormatter ()

@property(nonatomic, retain) NSDateFormatter *dateFromatter;

@end

@implementation LogFormatter

- (id)init {
  if (self = [super init]) {
    _dateFromatter = [[NSDateFormatter alloc] init];
    [_dateFromatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [_dateFromatter setDateFormat:DATE_FORMAT];
  }
  
  return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
  NSString *date = [self.dateFromatter stringFromDate:logMessage->timestamp];
  NSString *level = [LogFormatter getLogFlagString:logMessage->logFlag];
  
  return [NSString stringWithFormat:LOG_FORMAT, date, level, logMessage->file, logMessage->function, logMessage->logFlag, logMessage->logContext, logMessage->lineNumber, logMessage->machThreadID, logMessage->threadName, logMessage->queueLabel, logMessage->logMsg];
}

+ (NSString *)getLogFlagString:(int)flag{
  switch (flag) {
    case LOG_FLAG_VERBOSE:
      return @"V";
    case LOG_FLAG_DEBUG:
      return @"D";
    case LOG_FLAG_INFO:
      return @"I";
    case LOG_FLAG_WARN:
      return @"W";
    case LOG_FLAG_ERROR:
      return @"E";
    default:
      break;
  }
  
  return @"Unknown";
}

@end
