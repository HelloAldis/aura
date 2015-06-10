//
//  DiscoveryViewController.m
//  AURA
//
//  Created by MacMiniS on 15-4-13.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "AURA.h"
#import "APIManager.h"
#import "DataManager.h"
#import "HomeCell.h"

#define DIS_TYPE_ALL 1
#define DIS_TYPE_NEAR 2
#define DIS_TYPE_CITY 3

#define UNSELECT_COLOR [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1.0]

@interface DiscoveryViewController ()

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UIButton *btnDisAll;
@property (nonatomic, strong) UIButton *btnDisNear;
@property (nonatomic, strong) UIButton *btnDisCity;
@property (nonatomic, assign) NSInteger disType;

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
//  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//  self.searchController.hidesNavigationBarDuringPresentation = NO;
//  [self.searchController.searchBar sizeToFit];
//  [self.view addSubview:self.searchController.searchBar];
  
  [self initNav];
  [self initRefreshControl];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self handleRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.navigationController.view addSubview:self.btnDisAll];
  [self.navigationController.view addSubview:self.btnDisNear];
  [self.navigationController.view addSubview:self.btnDisCity];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [self.btnDisAll removeFromSuperview];
  [self.btnDisNear removeFromSuperview];
  [self.btnDisCity removeFromSuperview];
}

- (void)initNav {
  self.disType = DIS_TYPE_ALL;
  
  self.btnDisAll = [[UIButton alloc] initWithFrame:CGRectMake(80, 20, 80, 44)];
  [self.btnDisAll setTitle:@"探索" forState:UIControlStateNormal];
  [self.btnDisAll.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
  [self.btnDisAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.btnDisAll setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
  [self.btnDisAll addTarget:self action:@selector(onClickDiscoveryAll) forControlEvents:UIControlEventTouchUpInside];
//  self.btnDisNear = [[UIButton alloc] initWithFrame:CGRectMake(107, 20, 106, 44)];
//  [self.btnDisNear setTitle:@"附近" forState:UIControlStateNormal];
//  [self.btnDisNear.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
//  [self.btnDisNear setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//  [self.btnDisNear setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//  [self.btnDisNear addTarget:self action:@selector(onClickDiscoveryNear) forControlEvents:UIControlEventTouchUpInside];
  
  self.btnDisCity = [[UIButton alloc] initWithFrame:CGRectMake(160, 20, 80, 44)];
  [self.btnDisCity setTitle:@"同城" forState:UIControlStateNormal];
  [self.btnDisCity.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
  [self.btnDisCity setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  [self.btnDisCity setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
  [self.btnDisCity addTarget:self action:@selector(onClickDiscoveryCity) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initRefreshControl {
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.tintColor = [AURA themeColor];
  [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
}

- (void)onClickDiscoveryAll {
  if (self.disType != DIS_TYPE_ALL) {
    self.disType = DIS_TYPE_ALL;
    [self.btnDisAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnDisNear setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
    [self.btnDisCity setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
    [self.btnDisAll.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [self.btnDisCity.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [self handleRefresh];
  }
}

- (void)onClickDiscoveryNear {
  if (self.disType != DIS_TYPE_NEAR) {
    self.disType = DIS_TYPE_NEAR;
    [self.btnDisAll setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
    [self.btnDisNear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnDisCity setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
    [self handleRefresh];
  }
}

- (void)onClickDiscoveryCity {
  if (self.disType != DIS_TYPE_CITY) {
    self.disType = DIS_TYPE_CITY;
    [self.btnDisAll setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
    [self.btnDisNear setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
    [self.btnDisCity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnDisCity.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [self.btnDisAll.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [self handleRefresh];
  }
}

#pragma mark - handle refresh
- (void)handleRefresh {
  if (self.disType == DIS_TYPE_ALL) {
    [APIManager discoveryAll:^{
      [self.tableView reloadData];
      [self.refreshControl endRefreshing];
    } failure:^{
      [self.refreshControl endRefreshing];
    }];
  } else if (self.disType == DIS_TYPE_NEAR) {
    [APIManager discoveryNearSuccess:^{
      [self.tableView reloadData];
      [self.refreshControl endRefreshing];
    } failure:^{
      [self.refreshControl endRefreshing];
    }];
  } else if (self.disType == DIS_TYPE_CITY) {
    [APIManager discoveryCity:^{
      [self.tableView reloadData];
      [self.refreshControl endRefreshing];
    } failure:^{
      [self.refreshControl endRefreshing];
    }];
  }
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [DataManager discoveryArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
  [cell initWithPhoto:[[DataManager discoveryArray] objectAtIndex:indexPath.row] andIndexPath:indexPath];
  cell.supperController = self;
  return cell;
}

@end
