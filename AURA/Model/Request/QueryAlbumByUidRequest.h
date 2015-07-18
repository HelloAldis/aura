//
//  QueryAlbumByUidRequest.h
//  AURA
//
//  Created by KindAzrael on 15/7/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface QueryAlbumByUidRequest : NeedLoginRequest

- (void)setuserid:(NSString *)userid;

@end
