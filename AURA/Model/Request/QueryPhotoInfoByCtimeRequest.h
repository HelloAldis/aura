//
//  QueryPhotoInfoByCtime.h
//  AURA
//
//  Created by MacMiniS on 15-3-9.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface QueryPhotoInfoByCtimeRequest : NeedLoginRequest

- (void)setAlbumid:(NSString *)albumid;
- (void)setcursor:(NSString *)cursor;
- (void)setsize:(NSInteger )size;

@end
