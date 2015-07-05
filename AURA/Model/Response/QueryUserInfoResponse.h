//
//  QueryUserInfoResponse.h
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "BaseResponse.h"

@interface QueryUserInfoResponse : BaseResponse

- (NSArray *)follower;
- (NSArray *)followee;
- (NSString *)sign;
//- (NSString *)nickname;
//- (NSString *)userid;
//- (NSString *)thumbnail;

@end
