//
//  UpdateNickname.m
//  AURA
//
//  Created by KindAzrael on 15/7/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "UpdateNicknameRequest.h"

@implementation UpdateNicknameRequest

- (void)setnickname:(NSString *)nickname {
  [self.data setObject:nickname forKey:@"nickname"];
}

@end
