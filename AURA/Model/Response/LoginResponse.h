//
//  LoginResponse.h
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseResponse.h"

@interface LoginResponse : BaseResponse

- (NSString *)token;
- (NSString *)userid;
- (NSString *)nickname;

@end
