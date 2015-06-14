//
//  SearchNicknameRequest.m
//  AURA
//
//  Created by KindAzrael on 15/6/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "SearchNicknameRequest.h"

@implementation SearchNicknameRequest

- (void)setnickname:(NSString *)nickname {
  [self.data setObject:nickname forKey:@"nickname"];
}

@end
