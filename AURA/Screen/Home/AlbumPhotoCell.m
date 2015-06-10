//
//  AlbumPhotoCell.m
//  AURA
//
//  Created by MacMiniS on 14-10-30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AlbumPhotoCell.h"
#import "UIImageView+Util.h"
#import "MainToolbar.h"
#import "NSString+Util.h"
#import "APIManager.h"
#import "DataManager.h"
#import "UIView+Util.h"
#import "ViewControllerContainer.h"
#import "NSDate+Util.h"
#import "SVProgressHUD.h"

@interface AlbumPhotoCell ()

@property (nonatomic, strong) Photo *photo;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation AlbumPhotoCell

- (void)initWithPhoto:(Photo *)photo andIndexPath:(NSIndexPath *)indexPath {
  [self.photoImageView setImageeWithSha1:photo.sha1 withPlaceHolder:nil];
  self.lblFcount.text = photo.fcount;
  self.userImageView.image = [DataManager defaultUserImage];
  [self.userImageView setCornerRadius:20];
  [self.userImageView setBorder:1 andColor:[[UIColor whiteColor] CGColor]];
  self.lblUsername.text = photo.creatorinfo.nickname;
  self.lblCtime.text = [NSDate getTimeStringFrom:photo.ctime];
  
  if (photo.haveFavourte) {
    [self.btnLike setImage:[UIImage imageNamed:@"05相册外_赞点击态"] forState:UIControlStateNormal];
  } else {
    [self.btnLike setImage:[UIImage imageNamed:@"05相册外_赞"] forState:UIControlStateNormal];
  }
  
  self.photo = photo;
  self.indexPath = indexPath;
}

- (IBAction)onClickMore:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [MainToolbar showMainToolbar];
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    [SVProgressHUD showSuccessWithStatus:@"你的举报我们已经收到"];
    [MainToolbar showMainToolbar];
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    [MainToolbar showMainToolbar];
    DeletePhotoRequest *request = [[DeletePhotoRequest alloc] init];
    [request setPhotoid:self.photo.photoid];
    [APIManager deletePhoto:request success:^{
      [[DataManager photoArray] removeObjectAtIndex:self.indexPath.row];
      [self.supperController.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^{}];
  }]];
  
  [self.supperController presentViewController:alertController animated:YES completion:nil];
  [MainToolbar hideMainToolbar];
}

- (IBAction)onClickUser:(id)sender {
  if ([DataManager isMe:self.photo.creatorinfo.userid]) {
    [MainToolbar clickSecond];
  } else {
    [ViewControllerContainer showUserCenter:self.photo.creatorinfo];
  }
}

- (IBAction)onClickLike:(id)sender {
  if (!self.photo.haveFavourte) {
    FavouriteRequest *request = [[FavouriteRequest alloc] init];
    [request setPhotoid:self.photo.photoid];
    [APIManager favourite:request success:^{
      self.lblFcount.text = [self.photo.fcount add:1];
      [self.btnLike setImage:[UIImage imageNamed:@"05相册外_赞点击态"] forState:UIControlStateNormal];
      self.photo.haveFavourte = YES;
    } failure:^{}];
  }
}

- (IBAction)onClickComment:(id)sender {
  [ViewControllerContainer showPhotoDetail:self.photo];
}

@end
