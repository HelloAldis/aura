//
//  FollowerCellTableViewCell.h
//  AURA
//
//  Created by MacMiniS on 15-1-5.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowUser.h"

@interface FollowerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *relationImage;

- (void)initwithFollowee:(FollowUser *)followUser;
- (void)initwithFollower:(FollowUser *)followUser;

@end
