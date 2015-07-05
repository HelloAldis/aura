//
//  MapViewController.m
//  AURA
//
//  Created by KindAzrael on 15/7/4.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "MapViewController.h"
#import "AlbumAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self initNav];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.albumInfo.geo.lat, self.albumInfo.geo.lng);
  MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.05, 0.05));
  [self.mapView setRegion:region animated:YES];
  
  AlbumAnnotation *a = [[AlbumAnnotation alloc] init];
  a.c = coordinate;
  a.t = [NSString stringWithFormat:@"相册: %@", self.albumInfo.name];
  a.st = [NSString stringWithFormat:@"用户: %@", self.albumInfo.creatorinfo.nickname];
  [self.mapView addAnnotation:a];
}

- (void)initNav {
  self.title = self.albumInfo.name;
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(onBack)];
}

- (void)onBack {
  [self.navigationController popViewControllerAnimated:YES];
}



@end
