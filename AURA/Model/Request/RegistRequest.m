//
//  RegistRequest.m
//  AURA
//
//  Created by MacMiniS on 14-10-16.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "RegistRequest.h"

@implementation RegistRequest

- (void)setEmail:(NSString *)email {
  [self.data setObject:email forKey:@"email"];
}

- (void)setPassword:(NSString *)password {
  [self.data setObject:password forKey:@"password"];
}

- (void)setNickName:(NSString *)nickName {
  [self.data setObject:nickName forKey:@"nickname"];
}

@end
