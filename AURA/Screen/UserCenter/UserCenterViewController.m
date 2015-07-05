//
//  UserCenterViewController.m
//  AURA
//
//  Created by MacMiniS on 14-10-13.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "UserCenterViewController.h"
#import "AURA.h"
#import "ViewControllerContainer.h"
#import "UILabel+Util.h"
#import "UIView+Util.h"
#import "DataManager.h"
#import "APIManager.h"
#import "NSString+Util.h"
#import "Business.h"

@interface UserCenterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblSignature;
@property (weak, nonatomic) IBOutlet UILabel *lblPicCount;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *lblFcount;
@property (weak, nonatomic) IBOutlet UILabel *lblFolloweeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblFollowerCount;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *userBackgroundImageView;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.userImage setCornerRadius:35];
  [self.userImage setBorder:2 andColor:[[UIColor whiteColor] CGColor]];
  
  [self initNav];
}

- (void)viewWillAppear:(BOOL)animated {
  QueryUserInfoRequest *req = [[QueryUserInfoRequest alloc] init];
  [req setuserid:self.userId];
  
  [APIManager queryUserInfo:req success:^{
    [self initDisplay];
    [self initConttrol];
  } failure:^{}];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)initDisplay {
  self.title = self.nickname;
  NSString *signature = [DataManager userInfo].sign;
  [self.lblSignature setTextWithAutoSize:signature maxWidth:280];
  self.lblSignature.center = CGPointMake(160, self.lblSignature.center.y);
  self.lblPicCount.text = @"";
  self.lblFcount.text = @"";
  self.lblFolloweeCount.text = [NSString stringWithFormat:@"%ld", [DataManager userInfo].followee.count];
  self.lblFollowerCount.text = [NSString stringWithFormat:@"%ld", [DataManager userInfo].follower.count];;
  self.lblName.text = self.nickname;
  self.userBackgroundImageView.image = [DataManager defaultUserImage];
  self.userImage.image = [DataManager defaultUserImage];
}

- (void)initNav {
  if ([self.userId isMe]) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickAppSetting)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStyleDone target:self action:@selector(message)];
  } else {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  }
}

- (void)initConttrol {
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

- (void)message {
  
}

- (void)onClickBack {
  [self.navigationController popToRootViewControllerAnimated:YES];
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

- (void)onClickAppSetting {
  [ViewControllerContainer showAppSetting];
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
