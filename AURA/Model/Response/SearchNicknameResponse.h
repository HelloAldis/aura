//
//  SearchNicknameResponse.h
//  AURA
//
//  Created by KindAzrael on 15/6/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "BaseResponse.h"
#import "FollowUser.h"

@interface SearchNicknameResponse : BaseResponse

- (FollowUser *)userinfo;

@end
