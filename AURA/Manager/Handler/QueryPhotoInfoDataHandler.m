//
//  QueryPhotoInfoDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/4/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "QueryPhotoInfoDataHandler.h"
#import "QueryPhotoInfoByFCountResponse.h"
#import "Photo.h"
#import "DataManager.h"

@implementation QueryPhotoInfoDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  
  QueryPhotoInfoByFcountResponse *resp = (QueryPhotoInfoByFcountResponse *) baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.photoes.count];
  for (NSDictionary *dict in resp.photoes) {
    [array addObject:[[Photo alloc] initWithData:dict]];
  }
  
  [DataManager setPhotoArray:array];
}

@end
