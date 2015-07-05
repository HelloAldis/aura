//
//  DelFollowerRequest.m
//  AURA
//
//  Created by KindAzrael on 15/7/5.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "DelFollowerRequest.h"

@implementation DelFollowerRequest

- (void)setfollowerid:(NSString *)followerid {
  [self.data setObject:followerid forKey:@"followerid"];
}

@end
