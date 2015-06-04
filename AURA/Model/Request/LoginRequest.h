//
//  LoginRequest.h
//  AURA
//
//  Created by KindAzrael on 14-10-15.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

- (void)setAccount:(NSString *)account;
- (void)setPassword:(NSString *)password;
- (void)setType:(NSString *)type;

@end
