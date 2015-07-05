//
//  UserCenterViewController.h
//  AURA
//
//  Created by MacMiniS on 14-10-13.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseViewController.h"
#import "CreatorInfo.h"

@interface UserCenterViewController : BaseViewController

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *thumbnail;

@end