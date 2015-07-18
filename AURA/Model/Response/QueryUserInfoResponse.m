//
//  QueryUserInfoResponse.m
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryUserInfoResponse.h"

@implementation QueryUserInfoResponse

- (NSArray *)followee {
  return [self.data objectForKey:@"followee"];
}

- (NSArray *)follower {
  return [self.data objectForKey:@"follower"];
}

- (NSString *)sign {
  id o =[self.data objectForKey:@"sign"];
  if (o == [NSNull null]) {
    return @"";
  }
  return o;
}

- (NSString *)thumbnail {
  id o = [self.data objectForKey:@"thumbnail"];
  if (o == [NSNull null] || o == nil) {
    return @"";
  } else {
    return [self.data objectForKey:@"thumbnail"];
  }
}

- (NSString *)nickname {
  return [self.data objectForKey:@"nickname"];
}

@end
