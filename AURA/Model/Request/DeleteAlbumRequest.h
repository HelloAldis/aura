//
//  DeleteAlbumRequest.h
//  AURA
//
//  Created by Az on 15/4/23.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface DeleteAlbumRequest : NeedLoginRequest

- (void)setAlbumid:(NSString *)albumid;

@end
