//
//  FollowUser.m
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "FollowUser.h"

@implementation FollowUser

- (NSString *)email {
  return [self.data objectForKey:@"email"];
}

- (NSString *)mobile {
  return [self.data objectForKey:@"mobile"];
}

- (NSString *)userId {
  return [self.data objectForKey:@"userId"];
}

- (NSString *)nickname {
  return [self.data objectForKey:@"nickname"];
}

@end
