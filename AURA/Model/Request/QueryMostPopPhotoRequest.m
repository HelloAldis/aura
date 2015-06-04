//
//  QueryMostPopPhotoRequest.m
//  AURA
//
//  Created by MacMiniS on 15-4-7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryMostPopPhotoRequest.h"

@implementation QueryMostPopPhotoRequest

- (void)setsize:(NSInteger )size {
  [self.data setObject:[NSNumber numberWithInteger:size ] forKey:@"size"];
}

@end
