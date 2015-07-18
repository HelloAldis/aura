//
//  UpdateSignRequest.m
//  AURA
//
//  Created by KindAzrael on 15/7/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "UpdateSignRequest.h"

@implementation UpdateSignRequest

- (void)setsign:(NSString *)sign {
  [self.data setObject:sign forKey:@"sign"];
}

@end
