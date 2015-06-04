//
//  CreateAlbumRequest.c
//  AURA
//
//  Created by MacMiniS on 15-3-17.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "CreateAlbumRequest.h"
#import "DataManager.h"

@implementation CreateAlbumRequest

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

- (void)setName:(NSString *)name {
  [self.data setObject:name forKey:@"name"];
}

- (void)setTpye:(NSString *)type {
  [self.data setObject:type forKey:@"type"];
}

- (void)setonlyfindbyfriend:(int)onlyfindbyfriend {
  [self.data setObject:[NSNumber numberWithInt:onlyfindbyfriend] forKey:@"onlyfindbyfriend"];
}


@end
