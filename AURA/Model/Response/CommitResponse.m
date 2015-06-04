//
//  CommitResponse.m
//  AURA
//
//  Created by KindAzrael on 14/11/15.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "CommitResponse.h"

@implementation CommitResponse

- (NSString *)photoId {
  return [self.data objectForKey:@"photoid"];
}

@end
