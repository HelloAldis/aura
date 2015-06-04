//
//  DelFavouriteRequest.m
//  AURA
//
//  Created by MacMiniS on 15-3-9.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "DelFavouriteRequest.h"
#import "DataManager.h"

@implementation DelFavouriteRequest

- (void)setPhotoid:(NSString *)photoid {
  [self.data setObject:photoid forKey:@"photoid"];
}

@end
