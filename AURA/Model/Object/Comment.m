//
//  Comment.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (NSString *)comment {
  return [self.data objectForKey:@"comment"];
}

- (CreatorInfo *)from_user {
  return [[CreatorInfo alloc] initWithData:[self.data objectForKey:@"from_user"]];
}

@end
