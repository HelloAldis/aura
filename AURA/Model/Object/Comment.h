//
//  Comment.h
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "APIObject.h"
#import "CreatorInfo.h"

@interface Comment : APIObject

- (NSString *)comment;
- (CreatorInfo *)from_user;

@end
