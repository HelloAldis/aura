//
//  recommendPhotoesByCity.h
//  AURA
//
//  Created by KindAzrael on 15/4/25.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "NeedLoginRequest.h"

@interface RecommendPhotoesByCityRequest : NeedLoginRequest

- (void)setCity:(NSString *)city;
- (void)setCursor:(int)cursor;
- (void)setSize:(int)size;

@end
