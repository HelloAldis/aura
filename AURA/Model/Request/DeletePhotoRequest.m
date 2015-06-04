//
//  DeletePhotoRequest.m
//  AURA
//
//  Created by Az on 15/4/23.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "DeletePhotoRequest.h"

@implementation DeletePhotoRequest

- (void)setPhotoid:(NSString *)photoid {
  [self.data setObject:photoid forKey:@"photoid"];
}

@end
