//
//  LoginRequest.m
//  AURA
//
//  Created by KindAzrael on 14-10-15.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (void)setAccount:(NSString *)account {
  [self.data setObject:account forKey:@"username"];
}

- (void)setPassword:(NSString *)password {
  [self.data setObject:password forKey:@"password"];
}

- (void)setType:(NSString *)type {
  [self.data setObject:type forKey:@"type"];
}

@end
