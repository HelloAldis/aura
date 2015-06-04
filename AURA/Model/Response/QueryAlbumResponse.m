//
//  QueryAlbumResponse.m
//  AURA
//
//  Created by KindAzrael on 15/3/18.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryAlbumResponse.h"

@implementation QueryAlbumResponse

- (NSArray *)albums {
  return [self.data objectForKey:@"albums"];
}

@end
