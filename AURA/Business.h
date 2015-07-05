//
//  Business.h
//  AURA
//
//  Created by KindAzrael on 15/7/5.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "APIObject.h"

@interface Business : APIObject

+ (BOOL)isUserArray:(NSArray *)array hashId:(NSString *)userId;

@end
