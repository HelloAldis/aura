//
//  UserInfo.h
//  AURA
//
//  Created by KindAzrael on 15/7/5.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "APIObject.h"

@interface UserInfo : APIObject

@property (nonatomic, strong) NSArray *follower;
@property (nonatomic, strong) NSArray *followee;
@property (nonatomic, strong) NSString *sign;

//- (NSArray *)follower;
//- (NSArray *)followee;
//- (NSString *)sign;

@end
