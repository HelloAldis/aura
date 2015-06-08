//
//  AlbumInfoCell.m
//  AURA
//
//  Created by MacMiniS on 14-10-30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AlbumInfoCell.h"
#import "APIDefines.h"
#import "MainToolbar.h"
#import "ViewControllerContainer.h"
#import "APIManager.h"
#import "NSDate+Util.h"
#import "UIImageView+Util.h"
#import "TagLabel.h"

typedef enum : NSUInteger {
  indexOne,
  indexTwo,
} SwipeIndex;

@interface AlbumInfoCell ()

@property (assign, nonatomic) SwipeIndex swipeIndex;
@property (strong, nonatomic) UIView *tagView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIImageView *indexOne;
@property (weak, nonatomic) IBOutlet UIImageView *indexTwo;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblinfo;
@property (weak, nonatomic) IBOutlet UILabel *lblPeopleCount;
@property (weak, nonatomic) IBOutlet UILabel *lblFcount;
@property (weak, nonatomic) IBOutlet UILabel *lblTagCount;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (nonatomic, strong) AlbumInfo *albumInfo;
@property (nonatomic, strong) Photo *firstPhoto;

@end

@implementation AlbumInfoCell

- (void)awakeFromNib {
  UISwipeGestureRecognizer *gestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
  gestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
  [self.contentView addGestureRecognizer:gestureLeft];
  
  UISwipeGestureRecognizer *gestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
  gestureRight.direction = UISwipeGestureRecognizerDirectionRight;
  [self.contentView addGestureRecognizer:gestureRight];
  
  self.swipeIndex = indexOne;
  self.tagView = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 170)];
  [self.contentView addSubview:self.tagView];
}

- (void)initwithAlbumInfo:(AlbumInfo *)albumInfo andFirstImage:(Photo *)photo andTags:(NSSet *)tags{
  self.swipeIndex = indexOne;
  self.indexTwo.image = [UIImage imageNamed:@"04相册_轮播未选中"];
  self.indexOne.image = [UIImage imageNamed:@"04相册_轮播选中"];
  
  self.albumInfo = albumInfo;
  self.firstPhoto = photo;
  
  self.lblCategory.text = [AlbumInfoCell getLableByType:albumInfo.type];
  self.categoryImageView.image = [UIImage imageNamed:[AlbumInfoCell getCategoryByType:albumInfo.type]];
  self.lblName.text = albumInfo.name;
  self.lblPeopleCount.text = albumInfo.jcount;
  self.lblFcount.text = albumInfo.fcount;
  self.lblinfo.text = [NSString stringWithFormat:@"%@ %@", [NSDate getDateStringForm:albumInfo.mtime], albumInfo.location];
  self.lblTagCount.text = @"0";
  self.lblUsername.text = albumInfo.creatorinfo.nickname;
  [self.coverImageView setImageeWithSha1:photo.sha1 withPlaceHolder:nil];
  [self.backgroundImageView setImageeWithSha1:photo.sha1 withPlaceHolder:nil];
  
//  for (NSString *tag in tags) {
//    [TagLabel tagLabelWithTagString:tags];
//  }
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gesture{
  if (self.swipeIndex == indexOne) {
    //TODO show tags
    [UIView animateWithDuration:0.4 animations:^{
      self.infoView.frame = CGRectOffset(self.infoView.frame, -320, 0);
      self.tagView.frame = CGRectOffset(self.tagView.frame, -320, 0);
    } completion:^(BOOL finished) {
      if (finished) {
        self.indexOne.image = [UIImage imageNamed:@"04相册_轮播未选中"];
        self.indexTwo.image = [UIImage imageNamed:@"04相册_轮播选中"];
      }
    }];
    
    self.swipeIndex = indexTwo;
  }
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gesture{
  if (self.swipeIndex == indexTwo) {
    //TODO show info
    [UIView animateWithDuration:0.4 animations:^{
      self.infoView.frame = CGRectOffset(self.infoView.frame, 320, 0);
      self.tagView.frame = CGRectOffset(self.tagView.frame, 320, 0);
    } completion:^(BOOL finished) {
      if (finished) {
        self.indexTwo.image = [UIImage imageNamed:@"04相册_轮播未选中"];
        self.indexOne.image = [UIImage imageNamed:@"04相册_轮播选中"];
      }
    }];
    self.swipeIndex = indexOne;
  }
}

- (IBAction)onClickCamera:(id)sender {
  [ViewControllerContainer showCameraViewController];
}

- (IBAction)onClickMore:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [MainToolbar showMainToolbar];
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    [MainToolbar showMainToolbar];
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    [MainToolbar showMainToolbar];
    DeleteAlbumRequest *request = [[DeleteAlbumRequest alloc] init];
    [request setAlbumid:self.albumInfo.albumid];
    [APIManager deleteAlbum:request success:^{
      [self.supperController.navigationController popToRootViewControllerAnimated:YES];
    } failure:^{}];
  }]];
  
  [self.supperController presentViewController:alertController animated:YES completion:nil];
  [MainToolbar hideMainToolbar];
}

- (IBAction)onClickLike:(id)sender {
  
}

+ (NSString *)getLableByType:(NSString *)type {
  if ([type isEqualToString:PRIVATE]) {
    return @"私人";
  } else if ([type isEqualToString:SPORTS]) {
    return @"体育";
  }  else if ([type isEqualToString:TOURISM]) {
    return @"旅游";
  }  else if ([type isEqualToString:PARTY]) {
    return @"聚会";
  }  else if ([type isEqualToString:SHOW]) {
    return @"演出";
  }
  
  return nil;
}

+ (NSString *)getCategoryByType:(NSString *)type {
  if ([type isEqualToString:PRIVATE]) {
    return @"04相册_标签_green";
  } else if ([type isEqualToString:SPORTS]) {
    return @"04相册_标签_red";
  }  else if ([type isEqualToString:TOURISM]) {
    return @"04相册_标签_yellow";
  }  else if ([type isEqualToString:PARTY]) {
    return @"04相册_标签_blue";
  }  else if ([type isEqualToString:SHOW]) {
    return @"04相册_标签_purple";
  }
  
  return nil;
}

@end
