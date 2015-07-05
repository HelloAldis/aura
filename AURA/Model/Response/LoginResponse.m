//
//  LoginResponse.m
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

- (NSString *)token {
  return [self.data objectForKey:@"token"];
}

- (NSString *)userid {
  return [self.data objectForKey:@"userid"];
}

- (NSString *)nickname {
  return [self.data objectForKey:@"nickname"];
}

- (NSString *)thumbnail {
  id o = [self.data objectForKey:@"thumbnail"];
  if (o == [NSNull null] || o == nil) {
    return @"";
  } else {
    return [self.data objectForKey:@"thumbnail"];
  }
}

@end
