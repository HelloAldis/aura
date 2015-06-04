//
//  GetAllFollowerResponse.m
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "GetAllFollowerResponse.h"

@implementation GetAllFollowerResponse

- (NSArray *)follower {
  return [self.data objectForKey:@"follower"];
}

@end
