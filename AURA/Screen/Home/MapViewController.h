//
//  MapViewController.h
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import "AlbumInfo.h"

@interface MapViewController : BaseViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) AlbumInfo *albumInfo;

@end
