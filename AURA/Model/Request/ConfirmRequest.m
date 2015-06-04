//
//  ConfirmRequest.m
//  AURA
//
//  Created by MacMiniS on 14-10-16.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "ConfirmRequest.h"

@implementation ConfirmRequest

- (void)setToken:(NSString *)token {
  [self.data setObject:token forKey:@"token"];
}

@end
