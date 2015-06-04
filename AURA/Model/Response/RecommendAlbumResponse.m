//
//  RecommendAlbumResponse.m
//  AURA
//
//  Created by KindAzrael on 14/11/15.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "RecommendAlbumResponse.h"

@implementation RecommendAlbumResponse

- (NSArray *)albums {
  return [self.data objectForKey:@"albums"];
}

@end
