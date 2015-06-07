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
  [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)initUI {
  NSString *signature = @"";
  [self.lblSignature setTextWithAutoSize:signature maxWidth:280];
  self.lblSignature.center = CGPointMake(160, self.lblSignature.center.y);
  self.lblPicCount.text = @"";
  self.lblFcount.text = @"";
  self.lblFolloweeCount.text = @"0";
  self.lblFollowerCount.text = @"0";
  self.lblName.text = self.user.nickname;
  self.userBackgroundImageView.image = [DataManager defaultUserImage];
  
  if ([DataManager isMe:self.user.userid]) {
    [self.btnEdit setTitle:@"设置" forState:UIControlStateNormal];
  } else {
    [self.btnEdit setTitle:@"关注" forState:UIControlStateNormal];
  }
  
  self.userImage.image = [DataManager defaultUserImage];
}

- (void)initNav {
  if ([DataManager isMe:self.user.userid]) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickAppSetting)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStyleDone target:self action:@selector(message)];
  } else {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  }
}

- (void)message {
  
}

- (void)onClickBack {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onClickUserSetting:(id)sender {
  if ([DataManager isMe:self.user.userid]) {
    [ViewControllerContainer showUserSetting];
  } else {
    FollowRequest *request = [[FollowRequest alloc] init];
    [request setFolloweeid:self.user.userid];
    
    [APIManager follow:request success:^{
      [self.btnEdit setTitle:@"已关注" forState:UIControlStateNormal];
    } failure:^{}];
  }
}

- (void)onClickAppSetting {
  [ViewControllerContainer showAppSetting];
}

- (IBAction)onClickFollower:(id)sender {
  [ViewControllerContainer showFollower];
}

- (IBAction)onClickFollwee:(id)sender {
  [ViewControllerContainer showFollowee];
}

@end
