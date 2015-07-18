//
//  SearchAlbumByNameDataHandler.m
//  AURA
//
//  Created by KindAzrael on 15/6/14.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "SearchAlbumByNameDataHandler.h"
#import "SearchAlbumByNameResponse.h"
#import "Photo.h"

@implementation SearchAlbumByNameDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];
  
  SearchAlbumByNameResponse *resp = (SearchAlbumByNameResponse *)baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.albums.count];
  for (NSDictionary *dict in resp.albums) {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    if ([[dict objectForKey:@"coverinfo"] isKindOfClass:[NSDictionary class]]) {
      [data addEntriesFromDictionary:[dict objectForKey:@"coverinfo"]];
      [data setObject:dict forKey:@"albuminfo"];
      [data setObject:[dict objectForKey:@"creatorinfo"] forKey:@"creatorinfo"];
      [array addObject:[[Photo alloc] initWithData:data]];
    }
  }
  
  [DataManager setSearchAlbumArray:array];
}

@end
