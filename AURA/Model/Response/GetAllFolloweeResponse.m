//
//  GetAllFolloweeResponse.m
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "GetAllFolloweeResponse.h"

@implementation GetAllFolloweeResponse

- (NSArray *)followee {
  return [self.data objectForKey:@"followee"];
}

@end
