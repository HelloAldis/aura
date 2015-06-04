//
//  QueryPhotoInfoByFcountRequest.m
//  AURA
//
//  Created by MacMiniS on 15-3-9.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryPhotoInfoByFcountRequest.h"
#import "DataManager.h"

@implementation QueryPhotoInfoByFcountRequest

- (void)setAlbumid:(NSString *)albumid {
  [self.data setObject:albumid forKey:@"albumid"];
}

- (void)setcursor:(NSString *)cursor {
  [self.data setObject:cursor forKey:@"cursor"];
}

- (void)setsize:(NSInteger )size {
  [self.data setObject:[NSNumber numberWithInteger:size ] forKey:@"size"];
}

@end
