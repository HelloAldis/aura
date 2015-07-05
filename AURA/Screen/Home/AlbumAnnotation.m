//
//  AlbumAnnotation.m
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "AlbumAnnotation.h"

@implementation AlbumAnnotation

- (CLLocationCoordinate2D)coordinate {
  return self.c;
}

- (NSString *)title {
  return self.t;
}

- (NSString *)subtitle {
  return self.st;
}

@end
