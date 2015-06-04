//
//  CheckNickNameRequest.m
//  AURA
//
//  Created by MacMiniS on 14-10-16.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "CheckNickNameRequest.h"

@implementation CheckNickNameRequest

- (void)setNickName:(NSString *)nickName {
  [self.data setObject:nickName forKey:@"nickname"];
}

@end
