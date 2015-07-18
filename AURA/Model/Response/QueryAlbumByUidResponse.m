//
//  QueryAlbumByUidResponse.m
//  AURA
//
//  Created by KindAzrael on 15/7/15.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryAlbumByUidResponse.h"

@implementation QueryAlbumByUidResponse

- (NSArray *)albums {
  return [self.data objectForKey:@"albums"];
}

@end
