//
//  CommitRequest.h
//  AURA
//
//  Created by KindAzrael on 14/11/15.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface CommitRequest : NeedLoginRequest

- (void)setAlbumId:(NSString *)albumId;
- (void)setSha1:(NSString *)sha1;

@end
