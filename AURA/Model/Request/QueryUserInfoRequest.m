//
//  QueryUserInfoRequest.m
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryUserInfoRequest.h"

@implementation QueryUserInfoRequest

- (void)setuserid:(NSString *)userid {
  [self.data setObject:userid forKey:@"userid"];
}

@end
