//
//  CreateAlbumRequest.h
//  AURA
//
//  Created by KindAzrael on 14/10/26.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface CreateAlbumRequest : NeedLoginRequest

- (void)setName:(NSString *)name;
- (void)setTpye:(NSString *)type;
- (void)setonlyfindbyfriend:(int)value;

@end