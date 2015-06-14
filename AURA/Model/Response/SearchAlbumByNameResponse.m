//
//  SearchAlbumByNameResponse.m
//  AURA
//
//  Created by KindAzrael on 15/6/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "SearchAlbumByNameResponse.h"

@implementation SearchAlbumByNameResponse

- (NSArray *)albums {
  return [self.data objectForKey:@"albums"];
}

@end
