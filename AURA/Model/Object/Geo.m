//
//  Geo.m
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "Geo.h"

@implementation Geo

- (float)lat {
  return [[self.data objectForKey:@"lat"] floatValue];
}

- (float)lng {
  return [[self.data objectForKey:@"lng"] floatValue];
}

@end
