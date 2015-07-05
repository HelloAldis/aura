//
//  AlbumInfo.m
//  AURA
//
//  Created by KindAzrael on 14-9-27.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AlbumInfo.h"

@implementation AlbumInfo

- (NSString *)onlyfindbyfriend {
  return [self.data objectForKey:@"city"];
}

- (NSString *)type {
  return [self.data objectForKey:@"type"];
}

- (NSString *)mtime {
  return [self.data objectForKey:@"mtime"];
}

- (NSString *)name {
  return [self.data objectForKey:@"name"];
}

- (NSString *)albumid {
  return [self.data objectForKey:@"albumid"];
}

- (NSString *)fcount {
  return [self.data objectForKey:@"fcount"];
}

- (NSString *)jcount {
  return [self.data objectForKey:@"jcount"];
}

- (NSString *)location {
  return [self.data objectForKey:@"location"];
}

- (CreatorInfo *)creatorinfo {
  return [[CreatorInfo alloc] initWithData:[self.data objectForKey:@"creatorinfo"]];
}

- (Geo *)geo {
  return [[Geo alloc] initWithData:[self.data objectForKey:@"geo"]];
}

- (NSString *)tags {
  return [self.data objectForKey:@"tags"];
}

@end
