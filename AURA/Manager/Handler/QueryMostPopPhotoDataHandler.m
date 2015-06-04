//
//  QueryMostPopPhoto.m
//  AURA
//
//  Created by KindAzrael on 15/4/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryMostPopPhotoDataHandler.h"
#import "QueryMostPopPhotoResponse.h"
#import "DataManager.h"
#import "Photo.h"

@implementation QueryMostPopPhotoDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  
  QueryMostPopPhotoResponse *resp = (QueryMostPopPhotoResponse *) baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.photoes.count];
  for (NSDictionary *dict in resp.photoes) {
    [array addObject:[[Photo alloc] initWithData:dict]];
  }
  
  [DataManager setMostPopPhotoArray:array];
}

@end
