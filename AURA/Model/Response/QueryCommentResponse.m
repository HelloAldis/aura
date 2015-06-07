//
//  QueryCommentResponse.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryCommentResponse.h"

@implementation QueryCommentResponse

- (NSArray *)comments {
  return [self.data objectForKey:@"comments"];
}

@end
