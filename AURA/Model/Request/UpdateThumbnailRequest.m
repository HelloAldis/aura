//
//  UpdateThumbnailRequest.m
//  AURA
//
//  Created by KindAzrael on 15/7/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "UpdateThumbnailRequest.h"

@implementation UpdateThumbnailRequest

- (void)setthumbnail:(NSString *)thumbnail {
  [self.data setObject:thumbnail forKey:@"thumbnail"];
}

@end
