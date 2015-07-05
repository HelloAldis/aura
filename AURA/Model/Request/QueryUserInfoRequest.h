//
//  QueryUserInfoRequest.h
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface QueryUserInfoRequest : NeedLoginRequest

- (void)setuserid:(NSString *)userid;

@end
