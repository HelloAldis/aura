//
//  CreateAlbumResponse.m
//  AURA
//
//  Created by KindAzrael on 14/10/26.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "CreateAlbumResponse.h"

@implementation CreateAlbumResponse

- (NSString *)albumId {
  return [self.data objectForKey:@"albumid"];
}

@end
