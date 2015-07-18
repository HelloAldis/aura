//
//  UserCenterViewController.h
//  AURA
//
//  Created by MacMiniS on 14-10-13.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CreatorInfo.h"

@interface UserCenterViewController : BaseTableViewController

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) BOOL showAppSetting;

@end