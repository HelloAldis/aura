//
//  QueryPhotoInfoByFcount.m
//  AURA
//
//  Created by MacMiniS on 15-3-20.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryPhotoInfoByFcountResponse.h"

@implementation QueryPhotoInfoByFcountResponse

- (NSArray *)photoes {
  return [self.data objectForKey:@"photoes"];
}

@end
