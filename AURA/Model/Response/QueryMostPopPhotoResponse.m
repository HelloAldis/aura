//
//  QueryMostPopPhotoResponse.m
//  AURA
//
//  Created by KindAzrael on 15/4/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryMostPopPhotoResponse.h"

@implementation QueryMostPopPhotoResponse

- (NSArray *)photoes {
  return [self.data objectForKey:@"photoes"];
}

@end
