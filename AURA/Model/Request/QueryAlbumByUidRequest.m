//
//  QueryAlbumByUidRequest.m
//  AURA
//
//  Created by KindAzrael on 15/7/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryAlbumByUidRequest.h"

@implementation QueryAlbumByUidRequest

- (void)setuserid:(NSString *)userid {
  [self.data setObject:userid forKey:@"userid"];
}

@end
