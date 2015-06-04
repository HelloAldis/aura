//
//  DiscoveryResponse.m
//  AURA
//
//  Created by KindAzrael on 15/4/25.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "DiscoveryResponse.h"

@implementation DiscoveryResponse

- (NSArray *)photoes {
  return [self.data objectForKey:@"photoes"];
}

@end
