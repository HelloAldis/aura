//
//  RegistRequest.h
//  AURA
//
//  Created by MacMiniS on 14-10-16.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseRequest.h"

@interface RegistRequest : BaseRequest

- (void)setEmail:(NSString *)email;
- (void)setPassword:(NSString *)password;
- (void)setNickName:(NSString *)nickName;

@end
