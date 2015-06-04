//
//  BaseDataHandler.h
//  AURA
//
//  Created by MacMiniS on 14-10-20.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
#import "DataManager.h"

@protocol BaseHander <NSObject>

@required
+ (void)handleResponse:(BaseResponse *)baseResponse;

@end

@interface BaseDataHandler : NSObject<BaseHander>

@end
