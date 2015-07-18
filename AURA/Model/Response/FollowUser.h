//
//  FollowUser.h
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "APIObject.h"

@interface FollowUser : APIObject

- (NSString *)email;
- (NSString *)mobile;
- (NSString *)nickname;
- (NSString *)userId;
- (NSString *)thumbnail;

@end
