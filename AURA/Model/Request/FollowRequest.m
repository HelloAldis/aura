//
//  FollowRequest.m
//  AURA
//
//  Created by KindAzrael on 14/12/28.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "FollowRequest.h"
#import "DataManager.h"

@implementation FollowRequest

- (void)setFolloweeid:(NSString *)followeeid {
  [self.data setObject:followeeid forKey:@"followeeid"];
}

@end
