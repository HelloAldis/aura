//
//  ImageCacheEntity.h
//  AURA
//
//  Created by MacMiniS on 14-11-12.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageCacheEntity : NSManagedObject

@property (nonatomic, retain) NSString * sha1;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * date;

@end
