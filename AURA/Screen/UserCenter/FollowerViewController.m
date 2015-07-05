//
//  FollowerScreenViewController.m
//  AURA
//
//  Created by MacMiniS on 15-1-5.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "FollowerViewController.h"
#import "FollowerCell.h"
#import "UIView+Util.h"
#import "APIManager.h"
#import "DataManager.h"

@interface FollowerViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FollowerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"FollowerCell" bundle:nil] forCellReuseIdentifier:@"FollowerCell"];
  [self initNav];
}

- (void)viewWillAppear:(BOOL)animated {
  GetAllFollowerRequest *req1 = [[GetAllFollowerRequest alloc] init];
  [APIManager getAllFollower:req1 success:^{
    [self.tableView reloadData];
  } failure:^{}];
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.title = @"我的粉丝";
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [DataManager userInfo].follower.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FollowerCell *followerCell = [tableView dequeueReusableCellWithIdentifier:@"FollowerCell" forIndexPath:indexPath];
  [followerCell initwithFollower:[[DataManager userInfo].follower objectAtIndex:indexPath.row]];
  return followerCell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

@end
