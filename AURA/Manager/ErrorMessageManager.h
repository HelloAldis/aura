//
//  ErrorMessageManager.h
//  AURA
//
//  Created by KindAzrael on 14/10/19.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorMessageManager : NSObject

+ (NSString *)handleMessage:(NSString *)resultCode;

@end
