//
//  Business.m
//  AURA
//
//  Created by KindAzrael on 15/7/5.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "Business.h"
#import "FollowUser.h"

@implementation Business

+ (BOOL)isUserArray:(NSArray *)array hashId:(NSString *)userId {
  for (FollowUser *user in array) {
    if ([userId isEqualToString:user.userId]) {
      return YES;
    }
  }
  
  return NO;
}

@end
