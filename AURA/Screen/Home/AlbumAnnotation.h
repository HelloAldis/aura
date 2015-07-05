//
//  AlbumAnnotation.h
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AlbumAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D c;
@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *st;

@end
