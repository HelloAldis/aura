//
//  Photo.h
//  AURA
//
//  Created by KindAzrael on 15/4/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "APIObject.h"
#import "AlbumInfo.h"

@interface Photo : APIObject

- (NSString *)city;
- (NSString *)cityid;
- (NSString *)sha1;
- (NSString *)photoid;
- (NSString *)ctime;
- (NSString *)fcount;
- (AlbumInfo *)albuminfo;
- (BOOL)haveFavourte;
- (void)setHaveFavourte:(BOOL)value;
- (CreatorInfo *)creatorinfo;

@end
