//
//  RecommendAlbumResponse.m
//  AURA
//
//  Created by KindAzrael on 15/3/8.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "RecommendAlbumDataHandler.h"
#import "Photo.h"
#import "RecommendAlbumResponse.h"

@implementation RecommendAlbumDataHandler

+ (void)handleResponse:(BaseResponse *)baseResponse {
  [super handleResponse:baseResponse];

  RecommendAlbumResponse *resp = (RecommendAlbumResponse *)baseResponse;
  
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resp.albums.count];
  for (NSDictionary *dict in resp.albums) {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    if ([[dict objectForKey:@"coverinfo"] isKindOfClass:[NSDictionary class]]) {
      [data addEntriesFromDictionary:[dict objectForKey:@"coverinfo"]];
      [data setObject:dict forKey:@"albuminfo"];
      [array addObject:[[Photo alloc] initWithData:data]];
    }
  }
  
  [DataManager setRecommendAlbumArray:array];
  
  
}
     /*
     
     {
       "albums":[
                 {
                   "onlyfindbyfriend":"0",
                   "coverinfo":{
                     "city":"武汉市",
                     "sha1":"c08315aed95df53fe89385290c803bc0d5fbb74d",
                     "photoid":"273",
                     "cityid":"2",
                     "haveFavourte":false,
                     "fcount":"0"
                   },
                   "userid":"85",
                   "creatorinfo":{
                     "nickname":"a",
                     "thumbnail":null
                   },
                   "cityid":"2",
                   "albumid":"5",
                   "location":"湖北省武汉市洪山区三环线",
                   "jcount":"1",
                   "type":"party",
                   "fcount":"0"
                 }
                 ],
       "result_code":10000
     }
      */
     /*
     {
       "result_code":10000,
       "photoes":[
                  {
                    "albuminfo":{
                      "onlyfindbyfriend":"0",
                      "name":"1 photo",
                      "creatorinfo":{
                        "nickname":"a",
                        "thumbnail":null
                      },
                      "albumid":"5",
                      "location":"湖北省武汉市洪山区三环线",
                      "mtime":"2015-04-23 21:17:04",
                      "jcount":"1",
                      "type":"party",
                      "fcount":"0"
                    },
                    "sha1":"c08315aed95df53fe89385290c803bc0d5fbb74d",
                    "photoid":"273",
                    "ctime":"2015-04-23 21:17:05",
                    "city":"武汉市",
                    "userid":"85",
                    "cityid":"2",
                    "albumid":"5",
                    "haveFavourte":false,
                    "fcount":"0"
                  }
                  ]
     } */

@end
