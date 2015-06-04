//
//  recommendPhotoesByCity.m
//  AURA
//
//  Created by KindAzrael on 15/4/25.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "RecommendPhotoesByCityRequest.h"

@implementation RecommendPhotoesByCityRequest

- (void)setCity:(NSString *)city {
  [self.data setObject:city forKey:@"city"];
}

- (void)setCursor:(int)cursor {
  [self.data setObject:[NSNumber numberWithInt:cursor] forKey:@"cursor"];
}

- (void)setSize:(int)size {
  [self.data setObject:[NSNumber numberWithInt:size] forKey:@"size"];
}

@end
