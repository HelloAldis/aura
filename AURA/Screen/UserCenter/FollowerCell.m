//
//  FollowerCellTableViewCell.m
//  AURA
//
//  Created by MacMiniS on 15-1-5.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "FollowerCell.h"
#import "UIView+Util.h"
#import "DataManager.h"
#import "UIImageView+Util.h"
#import "DataManager.h"
#import "MainToolbar.h"
#import "ViewControllerContainer.h"
#import "NSString+Util.h"
#import "CreatorInfo.h"

@interface FollowerCell ()

@property (nonatomic, strong) FollowUser *followUser;

@end

@implementation FollowerCell

- (void)initwithFollowee:(FollowUser *)followUser {
  self.followUser = followUser;
  
  [self.userImage setUserImageWithSha1:followUser.thumbnail];
  [self.userImage setCornerRadius:20];
  self.username.text = [followUser nickname];
  self.relationImage.image = [UIImage imageNamed:@"10通知_icon_已关注"];
  self.username.text = followUser.nickname;
}

- (void)initwithFollower:(FollowUser *)followUser {
  self.followUser = followUser;
  
  [self.userImage setUserImageWithSha1:followUser.thumbnail];
  [self.userImage setCornerRadius:20];
  self.username.text = followUser.nickname;
  self.relationImage.image = [UIImage imageNamed:@"10通知_icon_加关注"];
  self.username.text = followUser.nickname;
}
- (IBAction)onClickUser:(id)sender {
    [ViewControllerContainer showUserCenter:self.followUser.userId];
}

@end
