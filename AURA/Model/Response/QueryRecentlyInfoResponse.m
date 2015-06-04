//
//  QueryRecentlyInfo.m
//  AURA
//
//  Created by MacMiniS on 15-4-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryRecentlyInfoResponse.h"

@implementation QueryRecentlyInfoResponse

- (NSArray *)photoes {
  return [self.data objectForKey:@"photoes"];
}

@end
