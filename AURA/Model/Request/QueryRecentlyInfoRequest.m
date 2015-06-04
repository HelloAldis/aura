//
//  QueryRecentlyInfoRequest.m
//  AURA
//
//  Created by MacMiniS on 15-4-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryRecentlyInfoRequest.h"

@implementation QueryRecentlyInfoRequest

- (void)setMtime:(NSString *)mtime {
  [self.data setObject:mtime forKey:@"mtime"];
}

@end
