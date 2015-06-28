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
#import "FollowerCell.h"

#define DIS_TYPE_ALL 1
#define DIS_TYPE_NEAR 2
#define DIS_TYPE_CITY 3

#define SCOPE_ALBUM 0
#define SCOPE_USER 1

#define UNSELECT_COLOR [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1.0]

@interface DiscoveryViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *btnDisAll;
@property (nonatomic, strong) UIButton *btnDisNear;
@property (nonatomic, strong) UIButton *btnDisCity;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, assign) NSInteger disType;
@property (strong, nonatomic) IBOutlet UIView *searchResultView;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scope;
@property (weak, nonatomic) IBOutlet UILabel *lblNoResult;

@property (nonatomic, assign) BOOL isInSearch;

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
  [self.searchResultTableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
  [self.searchResultTableView registerNib:[UINib nibWithNibName:@"FollowerCell" bundle:nil] forCellReuseIdentifier:@"FollowerCell"];
  
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
  self.isInSearch = NO;
  
  [self initNav];
  [self initRefreshControl];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if (!self.isInSearch) {
    [self handleRefresh];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (self.isInSearch) {
    [self addSearch];
  } else {
    [self addButtonsToNav];
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if (self.isInSearch) {
    [self removeSearch];
  } else {
    [self removeButtonsFromNva];
  }
}

- (void)addButtonsToNav {
  [self.navigationController.view addSubview:self.btnDisAll];
  [self.navigationController.view addSubview:self.btnDisNear];
  [self.navigationController.view addSubview:self.btnDisCity];
  [self.navigationController.view addSubview:self.btnSearch];
}

- (void)removeButtonsFromNva {
  [self.btnDisAll removeFromSuperview];
  [self.btnDisNear removeFromSuperview];
  [self.btnDisCity removeFromSuperview];
  [self.btnSearch removeFromSuperview];
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
  
  self.btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(280, 20, 44, 44)];
  [self.btnSearch setImage:[UIImage imageNamed:@"seach"] forState:UIControlStateNormal];
  [self.btnSearch.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
  [self.btnSearch setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  [self.btnSearch setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
  [self.btnSearch addTarget:self action:@selector(onClickSearch) forControlEvents:UIControlEventTouchUpInside];

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

- (void)onClickSearch {
  self.isInSearch = YES;
  [DataManager setSearchAlbumArray:nil];
  self.lblNoResult.hidden = YES;
  [self removeButtonsFromNva];
  [self initSearch];
  [self addSearch];
  [self.searchBar becomeFirstResponder];
}

- (void)addSearch {
  [self.navigationController.view addSubview:self.searchBar];
//  [self.navigationController.view addSubview:self.searchResultView];
  
//  [self.view insertSubview:self.searchResultView atIndex:100];
  [self.view insertSubview:self.searchResultView aboveSubview:self.view];
  self.tableView.scrollEnabled = NO;
}

- (void)removeSearch {
  [self.searchBar removeFromSuperview];
  [self.searchResultView removeFromSuperview];
  self.tableView.scrollEnabled = YES;
}

- (void)initSearch {
  if (!self.searchBar) {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    [self.searchBar sizeToFit];
    self.searchBar.barTintColor = [AURA themeColor];
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    [self.searchBar setBackgroundImage:[[UIImage alloc] init]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
  }
  
  self.searchResultView.frame = CGRectMake(0, 0, 320, 457);
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
- (IBAction)onScopeValueChange:(id)sender {
  [self.searchBar endEditing:YES];
  [self doSearch:self.searchBar.text];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.isInSearch && self.scope.selectedSegmentIndex == SCOPE_USER) {
    return 64;
  } else {
    return 470;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.isInSearch) {
    if (self.scope.selectedSegmentIndex == SCOPE_ALBUM) {
      return [DataManager searchAlbumArray].count;
    } else {
      return [DataManager searchUserArray].count;
    }
  } else {
    return [DataManager discoveryArray].count;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.isInSearch) {
    if (self.scope.selectedSegmentIndex == SCOPE_ALBUM) {
      HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
      [cell initWithPhoto:[[DataManager searchAlbumArray] objectAtIndex:indexPath.row] andIndexPath:indexPath andType:SEARCH_TYPE];
      cell.supperController = self;
      return cell;
    } else {
      FollowerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowerCell"];
      [cell initwithFollower:[[DataManager searchUserArray] objectAtIndex:indexPath.row]];
      return cell;
    }
  } else {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    [cell initWithPhoto:[[DataManager discoveryArray] objectAtIndex:indexPath.row] andIndexPath:indexPath andType:DISCOVERY_TYPE];
    cell.supperController = self;
    return cell;
  }
}

#pragma mark - search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [self doSearch:searchBar.text];
}

- (void)doSearch:(NSString *)text {
  self.lblNoResult.hidden = YES;
  [self.searchBar endEditing:YES];
  
  if (self.scope.selectedSegmentIndex == SCOPE_ALBUM) {
    SearchAlbumByNameRequest *req = [[SearchAlbumByNameRequest alloc] init];
    [req setalbumname:text];
    [APIManager searchAlbumByName:req success:^{
      [self.searchResultTableView reloadData];
    } failure:^{
      [self.searchResultTableView reloadData];
      if ([DataManager searchAlbumArray].count == 0) {
        self.lblNoResult.hidden = NO;
      }
    }];
  } else {
    SearchNicknameRequest *req = [[SearchNicknameRequest alloc] init];
    [req setnickname:text];
    [APIManager searchNickname:req success:^{
      [self.searchResultTableView reloadData];
    } failure:^{
      [self.searchResultTableView reloadData];
      if ([DataManager searchUserArray].count == 0) {
        self.lblNoResult.hidden = NO;
      }
    }];
  }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  self.isInSearch = NO;
  [self removeSearch];
  [self addButtonsToNav];
}

@end
