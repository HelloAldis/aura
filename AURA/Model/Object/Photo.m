//
//  Photo.m
//  AURA
//
//  Created by KindAzrael on 15/4/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (NSString *)city {
  return [self.data objectForKey:@"city"];
}

- (NSString *)sha1 {
  return [self.data objectForKey:@"sha1"];
}

- (NSString *)photoid {
  return [self.data objectForKey:@"photoid"];
}

- (NSString *)ctime {
  return [self.data objectForKey:@"ctime"];
}

- (NSString *)fcount {
  return [self.data objectForKey:@"fcount"];
}

- (NSString *)cityid {
  return [self.data objectForKey:@"cityid"];
}

- (AlbumInfo *)albuminfo {
  return [[AlbumInfo alloc] initWithData:[self.data objectForKey:@"albuminfo"]];
}

- (BOOL)haveFavourte {
  return [[self.data objectForKey:@"haveFavourte"] boolValue];
}

- (void)setHaveFavourte:(BOOL)value {
  [self.data setObject:[NSNumber numberWithBool:value] forKey:@"haveFavourte"];
}

- (CreatorInfo *)creatorinfo {
  return [[CreatorInfo alloc] initWithData:[self.data objectForKey:@"creatorinfo"]];
}

- (NSString *)tag {
  id o =[self.data objectForKey:@"tag"];
  if (o == [NSNull null]) {
    return nil;
  }
  return o;
}

@end
