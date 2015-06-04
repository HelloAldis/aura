//
//  QueryRecentlyInfoRequest.h
//  AURA
//
//  Created by MacMiniS on 15-4-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface QueryRecentlyInfoRequest : NeedLoginRequest

- (void)setMtime:(NSString *)mtime;

@end
