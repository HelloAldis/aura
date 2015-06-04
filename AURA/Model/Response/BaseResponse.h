//
//  BaseResponse.h
//  AURA
//
//  Created by KindAzrael on 14-10-11.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject

@property(strong, nonatomic) id data;

- (instancetype)initWithData:(id)data;
- (NSString *)resultCode;

@end
