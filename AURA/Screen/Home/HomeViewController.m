//
//  HomeViewController.m
//  AURA
//
//  Created by KindAzrael on 14/10/28.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "AURA.h"
#import "DataManager.h"
#import "UIImageView+Util.h"
#import "APIManager.h"

@interface HomeViewController ()

@property(strong, nonatomic) UIImageView *logo;

@end

@implementation HomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
  [self initRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  [self setNeedsStatusBarAppearanceUpdate];
  
  [self addlogo];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self handleRefresh];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self removeLogo];
}

- (void)initRefreshControl {
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.tintColor = [AURA themeColor];
  [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
}

- (void)addlogo {
  if (!self.logo) {
    UIImage *image = [UIImage imageNamed:@"logoaura"];
    self.logo = [[UIImageView alloc] initWithFrame:CGRectMake(128, 32, 64, 20)];
    self.logo.image = image;
  }
  
  [self.navigationController.view addSubview:self.logo];
}

- (void)removeLogo {
  [self.logo removeFromSuperview];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DataManager activityArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
  [cell initWithPhoto:[[DataManager activityArray] objectAtIndex:indexPath.row] andIndexPath:indexPath];
  cell.supperController = self;
  return cell;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - handle refresh
- (void)handleRefresh {
  QueryRecentlyInfoRequest *request = [[QueryRecentlyInfoRequest alloc] init];
  [request setMtime:@"2014-01-01 00:00:00"];
  
  [APIManager queryRecentlyInfo:request success:^{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
  } failure:^{
    [self.refreshControl endRefreshing];
  }];
}

@end
