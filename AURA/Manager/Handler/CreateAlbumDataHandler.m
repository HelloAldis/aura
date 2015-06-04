//
//  CreateAlbumDataHandler.m
//  AURA
//
//  Created by MacMiniS on 15-3-18.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "CreateAlbumDataHandler.h"
#import "CreateAlbumResponse.h"
#import "DataManager.h"

@implementation CreateAlbumDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  CreateAlbumResponse *resp = (CreateAlbumResponse *)baseResponse;
  [DataManager setLatestCreatedAlbumId:[resp albumId]];
}

@end
