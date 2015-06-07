//
//  QueryCommentRequest.h
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface QueryCommentRequest : NeedLoginRequest

- (void)setPhotoid:(NSString *)photoid;
- (void)setSize:(NSInteger)size;

@end
