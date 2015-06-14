//
//  SearchNicknameResponse.m
//  AURA
//
//  Created by KindAzrael on 15/6/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "SearchNicknameResponse.h"

@implementation SearchNicknameResponse

- (FollowUser *)userinfo {
  return [[FollowUser alloc] initWithData:[self.data objectForKey:@"userinfo"]];
}

@end
