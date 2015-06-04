//
//  RecommendAlbumRequest.m
//  AURA
//
//  Created by KindAzrael on 14/10/26.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "RecommendAlbumRequest.h"
#import "DataManager.h"

@implementation RecommendAlbumRequest

- (instancetype)init {
  if (self = [super init]) {
    [self setLatitude:[DataManager latitude]];
    [self setLongitude:[DataManager longitude]];
  }
  
  return self;
}

- (void)setLatitude:(double)latitude {
  [self.data setObject:[NSNumber numberWithDouble:latitude] forKey:@"latitude"];
}

- (void)setLongitude:(double)longitude {
  [self.data setObject:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];
}

@end
