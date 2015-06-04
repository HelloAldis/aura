//
//  ShareViewController.m
//  AURA
//
//  Created by MacMiniS on 15-3-17.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "ShareViewController.h"
#import "APIManager.h"
#import "DataManager.h"
#import "ShareActivityCell.h"
#import "ViewControllerContainer.h"
#import "NSString+Util.h"

@interface ShareViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UIView *addPanel;
@property (weak, nonatomic) IBOutlet UIView *createPanel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectTravel;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectSport;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectParty;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectShow;
@property (weak, nonatomic) IBOutlet UISwitch *switchOnlyShare;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *shareIndicator;

@property (strong, nonatomic) NSString *type;

@end

@implementation ShareViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initNav];
  [self initUI];
  [self.tableView registerNib:[UINib nibWithNibName:@"ShareActivityCell" bundle:nil] forCellReuseIdentifier:@"ShareActivityCell"];
  self.type = PRIVATE;
}

- (void)initUI {
  self.imageView.image = self.image;
  
  if ([DataManager recommendAlbumArray].count == 0) {
    self.createPanel.hidden = NO;
    self.addPanel.hidden = YES;
  } else {
    self.createPanel.hidden = YES;
    self.addPanel.hidden = NO;
  }

  [self refreshLableAndButton];
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.title = @"滤镜";
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if ([DataManager recommendAlbumArray].count > 0) {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
  }
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickShare:(id)sender {
  [self shareInprogress];
  
  CreateAlbumRequest *request = [[CreateAlbumRequest alloc] init];
  [request setName:[self.text.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
  [request setTpye:self.type];
  [request setonlyfindbyfriend:self.switchOnlyShare.isOn];
  
  if (self.addPanel.hidden) {
    //create and share
    [APIManager createAlbum:request success:^{
      [APIManager uploadImage:self.image success:^{
        CommitRequest *cReq = [[CommitRequest alloc] init];
        [cReq setAlbumId:[DataManager latestCreatedAlbumId]];
        [cReq setSha1:[DataManager latestUploadedImageId]];
        [APIManager commit:cReq success:^{
          [self shareFinished];
          [self shareSuccessfully];
        } failure:^{
          [self shareFinished];
        }];
      } failure:^{
        [self shareFinished];
      }];
    } failure:^{
      [self shareFinished];
    }];
  } else {
    // add to album
    [APIManager uploadImage:self.image success:^{
      CommitRequest *cReq = [[CommitRequest alloc] init];
      NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      Photo* photo = [[DataManager recommendAlbumArray] objectAtIndex:indexPath.row];
      [cReq setAlbumId:photo.albuminfo.albumid];
      [cReq setSha1:[DataManager latestUploadedImageId]];
      [APIManager commit:cReq success:^{
        [self shareFinished];
        [self shareSuccessfully];
      } failure:^{
        [self shareFinished];
      }];
    } failure:^{
      [self shareFinished];
    }];
  }
}

- (void)shareInprogress {
  self.shareImageView.hidden = YES;
  self.btnShare.enabled = NO;
  self.shareIndicator.hidden = NO;
  [self.shareIndicator startAnimating];
}

- (void)shareFinished {
  self.shareImageView.hidden = NO;
  self.btnShare.enabled = YES;
  self.shareIndicator.hidden = YES;
  [self.shareIndicator stopAnimating];
}

- (IBAction)onClickCreate:(id)sender {
  self.createPanel.hidden = NO;
  self.addPanel.hidden = YES;
}

-(void)shareSuccessfully {
  [ViewControllerContainer showOriginalScreenAfterShare];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [DataManager recommendAlbumArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ShareActivityCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShareActivityCell" forIndexPath:indexPath];
  [cell initWithPhoto:[[DataManager recommendAlbumArray] objectAtIndex:indexPath.row]];
  return cell;
}

#pragma mark - textView delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
  self.lblPlaceHolder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  [self refreshLableAndButton];
}

- (void)refreshLableAndButton {
  if ([self.text.text trim].length == 0) {
    self.lblPlaceHolder.hidden = NO;
    self.btnShare.enabled = NO;
  } else {
    self.lblPlaceHolder.hidden = YES;
    self.btnShare.enabled = YES;
  }
}

#pragma mark - user action
- (IBAction)onClickTravel:(id)sender {
  self.effectTravel.hidden = YES;
  self.effectParty.hidden = NO;
  self.effectShow.hidden = NO;
  self.effectSport.hidden = NO;
  self.type = TOURISM;
}

- (IBAction)onClickSport:(id)sender {
  self.effectTravel.hidden = NO;
  self.effectParty.hidden = NO;
  self.effectShow.hidden = NO;
  self.effectSport.hidden = YES;
  self.type = SPORTS;
}

- (IBAction)onClickParty:(id)sender {
  self.effectTravel.hidden = NO;
  self.effectParty.hidden = YES;
  self.effectShow.hidden = NO;
  self.effectSport.hidden = NO;
  self.type = PARTY;
}

- (IBAction)onClickShow:(id)sender {
  self.effectTravel.hidden = NO;
  self.effectParty.hidden = NO;
  self.effectShow.hidden = YES;
  self.effectSport.hidden = NO;
  self.type = SHOW;
}

@end
