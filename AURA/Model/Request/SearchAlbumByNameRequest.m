//
//  SearchAlbumByName.m
//  AURA
//
//  Created by KindAzrael on 15/6/13.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "SearchAlbumByNameRequest.h"

@implementation SearchAlbumByNameRequest

- (void)setalbumname:(NSString *)albumname {
  [self.data setObject:albumname forKey:@"albumname"];
}

@end
