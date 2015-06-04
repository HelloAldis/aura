//
//  ResponseHandler.h
//  AURA
//
//  Created by KindAzrael on 14/10/19.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"

@interface ResponseHandler : NSObject

+ (void)handleResponse:(BaseResponse *)baseResponse success:(void (^)(void))success failure:(void (^)(void))failure;
+ (void)handleNetworkIssue;

@end
