//
//  CheckNickNameResponse.m
//  AURA
//
//  Created by KindAzrael on 14/10/20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "CheckNickNameResponse.h"

@implementation CheckNickNameResponse

- (BOOL)exist {
  return [[self.data objectForKey:@"exist"] boolValue];
}

@end
