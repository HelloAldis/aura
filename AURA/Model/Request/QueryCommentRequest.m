//
//  QueryCommentRequest.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryCommentRequest.h"

@implementation QueryCommentRequest

- (void)setPhotoid:(NSString *)photoid {
  [self.data setObject:photoid forKey:@"photoid"];
}

- (void)setSize:(NSInteger)size {
  [self.data setObject:[NSNumber numberWithInteger:size] forKey:@"size"];
}

@end
