//
//  AlbumInfo.h
//  AURA
//
//  Created by KindAzrael on 14-9-27.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIObject.h"
#import "CreatorInfo.h"
#import "Geo.h"

@interface AlbumInfo : APIObject

- (NSString *)onlyfindbyfriend;
- (NSString *)type;
- (NSString *)name;
- (NSString *)mtime;
- (NSString *)albumid;
- (NSString *)jcount;
- (NSString *)fcount;
- (CreatorInfo *)creatorinfo;
- (NSString *)location;
- (Geo *)geo;
- (NSString *)tags;

@end
