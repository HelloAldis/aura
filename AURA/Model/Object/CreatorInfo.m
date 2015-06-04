//
//  CreatorInfo.m
//  AURA
//
//  Created by KindAzrael on 15/4/22.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "CreatorInfo.h"

@implementation CreatorInfo

- (NSString *)userid {
  return [self.data objectForKey:@"userid"];
}

- (NSString *)nickname {
  return [self.data objectForKey:@"nickname"];
}

- (NSString *)thumbnail {
  return [self.data objectForKey:@"thumbnail"];
}

@end
/*
{
  "albuminfo":{
    "onlyfindbyfriend":"0",
    "name":"1 photo",
    "userid":"85",
    "creatorinfo":{
      "nickname":"a",
      "userid":"85",
      "thumbnail":null
    },
    "albumid":"5",
    "location":"湖北省武汉市洪山区三环线",
    "mtime":"2015-04-23 21:17:04",
    "jcount":"1",
    "type":"party",
    "fcount":"2"
  },
  "sha1":"c08315aed95df53fe89385290c803bc0d5fbb74d",
  "photoid":"273",
  "city":"武汉市",
  "userid":"85",
  "creatorinfo":{
    "nickname":"a",
    "userid":"85",
    "thumbnail":null
  },
  "cityid":"2",
  "albumid":"5",
  "haveFavourte":true
}
{
  "albuminfo":{
    "onlyfindbyfriend":"0",
    "name":"1 photo",
    "userid":"85",
    "creatorinfo":{
      "nickname":"a",
      "userid":"85",
      "thumbnail":null
    },
    "albumid":"5",
    "location":"湖北省武汉市洪山区三环线",
    "mtime":"2015-04-23 21:17:04",
    "jcount":"1",
    "type":"party",
    "fcount":"2"
  },
  "sha1":"c08315aed95df53fe89385290c803bc0d5fbb74d",
  "photoid":"273",
  "ctime":"2015-04-23 21:17:05",
  "city":"武汉市",
  "userid":"85",
  "creatorinfo":{
    "nickname":"a",
    "userid":"85",
    "thumbnail":null
  },
  "cityid":"2",
  "albumid":"5",
  "haveFavourte":true,
  "fcount":"2"
}*/