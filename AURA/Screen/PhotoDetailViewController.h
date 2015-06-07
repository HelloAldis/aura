//
//  PhotoDetailViewController.h
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "BaseViewController.h"
#import "UUInputFunctionView.h"
#import "Photo.h"

@interface PhotoDetailViewController : BaseViewController<UUInputFunctionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Photo *photo;

@end
