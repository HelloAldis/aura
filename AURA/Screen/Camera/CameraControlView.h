//
//  CameraViewController.h
//  AURA
//
//  Created by MacMiniS on 14-10-10.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseViewController.h"

@interface CameraControlView : UIView<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property(weak, nonatomic) UIImagePickerController *imagePickerController;

+ (BOOL)startCameraControllerFromViewController: (UIViewController*) controller;

@end
