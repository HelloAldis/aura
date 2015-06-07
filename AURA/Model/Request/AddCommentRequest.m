//
//  AddComment.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "AddCommentRequest.h"

@implementation AddCommentRequest

- (void)setCommment:(NSString *)comment {
  [self.data setObject:comment forKey:@"comment"];
}

- (void)setPhotoid:(NSString *)photoid {
  [self.data setObject:photoid forKey:@"photoid"];
}

@end
