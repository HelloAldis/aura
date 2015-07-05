//
//  AlbumDetailViewController.m
//  AURA
//
//  Created by MacMiniS on 14-10-30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "AlbumPhotoCell.h"
#import "AlbumInfoCell.h"
#import "APIManager.h"
#import "DataManager.h"
#import "AURA.h"
#import "OrderView.h"
#import "BaseTableView.h"
#import "NSString+Util.h"

typedef enum : NSUInteger {
  OrderByFcount,
  OrderByTime,
} OrderBy;

@interface AlbumDetailViewController ()

@property (nonatomic, assign) OrderBy orderBy;
@property (nonatomic, strong) OrderView *orderView;
@property (nonatomic, strong) Photo* firstPhoto;

@end

@implementation AlbumDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"AlbumInfoCell" bundle:nil] forCellReuseIdentifier:@"AlbumInfoCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"AlbumPhotoCell" bundle:nil] forCellReuseIdentifier:@"AlbumPhotoCell"];
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
  
  self.orderBy = OrderByTime;
  [self initNav];
  [self initRefreshControl];
  [self handleRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self initStatusBar];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.orderView removeFromSuperview];
}

- (void)initStatusBar {
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)initRefreshControl {
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.tintColor = [AURA themeColor];
  [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(onBack)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"04相册_排序"] style:UIBarButtonItemStyleDone target:self action:@selector(resort)];
}

- (void)onBack {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self.orderView removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  [self.orderView removeFromSuperview];
}

- (void)resort {
  if (self.orderView == nil) {
    self.orderView = [OrderView orderView];
    [self.orderView.btnOrderByTIme addTarget:self action:@selector(onClickOrderByTime) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView.btnOrderFCount addTarget:self action:@selector(onClickOrderByFcount) forControlEvents:UIControlEventTouchUpInside];
    self.orderView.frame = CGRectMake(207, 56, 112, 94);
  }
  
  [((BaseTableView *)self.tableView) setFun:@selector(hideOrderView) withObject:self];
  [self.navigationController.view addSubview:self.orderView];
}

- (void)onClickOrderByTime {
  [self hideOrderView];
  if (self.orderBy != OrderByTime) {
    self.orderBy = OrderByTime;
    [self handleRefresh];
  }
}

- (void)onClickOrderByFcount {
  [self hideOrderView];
  if (self.orderBy != OrderByFcount) {
    self.orderBy = OrderByFcount;
    [self handleRefresh];
  }
}

- (void)hideOrderView {
  [self.orderView removeFromSuperview];
  [((BaseTableView *)self.tableView) setFun:nil withObject:nil];
}


- (void)handleRefresh {
  if (self.orderBy == OrderByTime) {
    QueryPhotoInfoByCtimeRequest *request = [[QueryPhotoInfoByCtimeRequest alloc] init];
    [request setAlbumid:self.albumInfo.albumid];
    [request setcursor:@"1"];
    [request setsize:1000];
    
    [APIManager queryPhotoInfoByCtime:request success:^{
      self.firstPhoto = [[DataManager photoArray] lastObject];
      [self.tableView reloadData];
      [self.refreshControl endRefreshing];
    } failure:^{
      [self.refreshControl endRefreshing];
    }];
  } else {
    QueryPhotoInfoByFcountRequest *request = [[QueryPhotoInfoByFcountRequest alloc] init];
    [request setAlbumid:self.albumInfo.albumid];
    [request setcursor:@"1"];
    [request setsize:1000];
    
    [APIManager queryPhotoInfoByFcount:request success:^{
      [self.tableView reloadData];
      [self.refreshControl endRefreshing];
    } failure:^{
      [self.refreshControl endRefreshing];
    }];
  }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return 210;
  } else {
    return 470;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [DataManager photoArray].count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    AlbumInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumInfoCell" forIndexPath:indexPath];
    [cell initwithAlbumInfo:self.albumInfo andFirstImage:self.firstPhoto andTags:[self.albumInfo.tags tags]];
    cell.supperController = self;
    return cell;
  } else {
    AlbumPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumPhotoCell" forIndexPath:indexPath];
    [cell initWithPhoto:[[DataManager photoArray] objectAtIndex:indexPath.row - 1] andIndexPath:indexPath];
    cell.supperController = self;
    return cell;
  }
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

@end
