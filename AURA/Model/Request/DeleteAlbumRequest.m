//
//  DeleteAlbumRequest.m
//  AURA
//
//  Created by Az on 15/4/23.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "DeleteAlbumRequest.h"

@implementation DeleteAlbumRequest

- (void)setAlbumid:(NSString *)albumid {
  [self.data setObject:albumid forKey:@"albumid"];
}

@end
