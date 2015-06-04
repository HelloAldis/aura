//
//  APIObject.h
//  AURA
//
//  Created by KindAzrael on 15/1/11.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIObject : NSObject

@property(strong, nonatomic) NSMutableDictionary * data;

- (instancetype)initWithData:(id)data;

@end
