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
#import "UIImageView+Util.h"
#import "HomeCell.h"
#import "UserCenterCellCell.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initNav];
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
  [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"UserCenterCellCell" bundle:nil] forCellReuseIdentifier:@"UserCenterCellCell"];
  
}

- (void)viewWillAppear:(BOOL)animated {
  QueryUserInfoRequest *req = [[QueryUserInfoRequest alloc] init];
  [req setuserid:self.userId];
  
  [APIManager queryUserInfo:req success:^{
    [self initDisplay];
    
    QueryAlbumByUidRequest *req2 =[[QueryAlbumByUidRequest alloc] init];
    [req2 setuserid:self.userId];
    [APIManager queryAlbumByUid:req2 success:^{
        [self.tableView reloadData];
    } failure:^{}];
  } failure:^{}];
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)initDisplay {
  self.title = [DataManager userInfo].nickname;
}

- (void)initNav {
  if ([self.userId isMe] && self.showAppSetting) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickAppSetting)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStyleDone target:self action:@selector(message)];
  } else {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  }
}

- (void)message {
  
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickAppSetting {
  [ViewControllerContainer showAppSetting];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return 215;
  } else {
    return 470;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [DataManager userInfo].myAlbum.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    UserCenterCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterCellCell" forIndexPath:indexPath];
    cell.userId = self.userId;
    [cell initDisplay];
    return cell;
  } else {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    [cell initWithPhoto:[[DataManager userInfo].myAlbum objectAtIndex:indexPath.row - 1] andIndexPath:indexPath andType:MYALBUM_TYPE];
    cell.supperController = self;
    return cell;
  }
}

@end
