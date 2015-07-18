//
//  UserCenterCellCell.m
//  AURA
//
//  Created by KindAzrael on 15/7/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "UserCenterCellCell.h"
#import "UILabel+Util.h"
#import "UIImageView+Util.h"
#import "DataManager.h"
#import "UIView+Util.h"
#import "NSString+Util.h"
#import "Business.h"
#import "APIManager.h"
#import "ViewControllerContainer.h"

@implementation UserCenterCellCell

- (void)initDisplay {
  [self.userImage setCornerRadius:35];
  [self.userImage setBorder:2 andColor:[[UIColor whiteColor] CGColor]];
  
  NSString *signature = [DataManager userInfo].sign;
  [self.lblSignature setTextWithAutoSize:signature maxWidth:280];
  self.lblSignature.center = CGPointMake(160, self.lblSignature.center.y);
  self.lblPicCount.text = @"";
  self.lblFcount.text = @"";
  self.lblFolloweeCount.text = [NSString stringWithFormat:@"%ld", [DataManager userInfo].followee.count];
  self.lblFollowerCount.text = [NSString stringWithFormat:@"%ld", [DataManager userInfo].follower.count];;
  self.lblName.text = [DataManager userInfo].nickname;
  [self.userBackgroundImageView setUserImageWithSha1:[DataManager userInfo].thumbnail];
  [self.userImage setUserImageWithSha1:[DataManager userInfo].thumbnail];
  
  if ([self.userId isMe]) {
    [self.btnEdit setTitle:@"设置" forState:UIControlStateNormal];
  } else {
    if ([Business isUserArray:[DataManager userInfo].follower hashId:[DataManager meId]]) {
      [self.btnEdit setTitle:@"取消关注" forState:UIControlStateNormal];
    } else {
      [self.btnEdit setTitle:@"关注" forState:UIControlStateNormal];
    }
  }
}

- (IBAction)onClickUserSetting:(id)sender {
  if ([self.userId isMe]) {
    [ViewControllerContainer showUserSetting];
  } else {
    if ([self.btnEdit.titleLabel.text isEqualToString:@"取消关注"]) {
      DelFollowerRequest *req = [[DelFollowerRequest alloc] init];
      [req setfollowerid:self.userId];
      
      [APIManager delFollower:req success:^{
        [self.btnEdit setTitle:@"关注" forState:UIControlStateNormal];
      } failure:^{
        
      }];
    } else {
      FollowRequest *request = [[FollowRequest alloc] init];
      [request setFolloweeid:self.userId];
      
      [APIManager follow:request success:^{
        [self.btnEdit setTitle:@"取消关注" forState:UIControlStateNormal];
      } failure:^{}];
    }
  }
}

- (IBAction)onClickFollower:(id)sender {
  if ([self.userId isMe]) {
    [ViewControllerContainer showFollower];
  }
}

- (IBAction)onClickFollwee:(id)sender {
  if ([self.userId isMe]) {
    [ViewControllerContainer showFollowee];
  }
}

@end
