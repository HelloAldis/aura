//
//  QueryCommentHandler.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryCommentDataHandler.h"
#import "QueryCommentResponse.h"
#import "Comment.h"

@implementation QueryCommentDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  
  QueryCommentResponse *resp = (QueryCommentResponse *)baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.comments.count];
  for (NSDictionary *dict in resp.comments) {
    [array addObject:[[Comment alloc] initWithData:dict]];
  }
  
  [DataManager setComments:array];
}

@end
