//
//  CommitRequest.m
//  AURA
//
//  Created by KindAzrael on 14/11/15.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "CommitRequest.h"
#import "DataManager.h"

@implementation CommitRequest

- (instancetype)init {
  if (self = [super init]) {
    [self setLatitude:[DataManager latitude]];
    [self setLongitude:[DataManager longitude]];
  }
  
  return self;
}

- (void)setLatitude:(double)latitude {
  [self.data setObject:[NSNumber numberWithDouble:latitude ] forKey:@"latitude"];
}

- (void)setLongitude:(double)longitude {
  [self.data setObject:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];
}

- (void)setAlbumId:(NSString *)albumId {
  [self.data setObject:albumId forKey:@"albumid"];
}

- (void)setSha1:(NSString *)sha1 {
  [self.data setObject:sha1 forKey:@"sha1"];
}

@end
