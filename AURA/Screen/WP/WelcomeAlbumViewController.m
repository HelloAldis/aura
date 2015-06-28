//
//  WelcomeAlbumViewController.m
//  AURA
//
//  Created by KindAzrael on 14-9-26.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "WelcomeAlbumViewController.h"
#import "AlbumInfoView.h"
#import "AlbumInfo.h"
#import "AURADefines.h"
#import "MathUtil.h"
#import "RecommendAlbumRequest.h"
#import "APIManager.h"
#import "DataManager.h"
#import "MainToolbar.h"

#define Y_DOT 425
#define Y_DISCOVERY 422
#define X_DOT_INC 20
#define X_DISCOVERY_INC 18
#define W_DOT 7
#define W_DISCOVERY 10
#define H_DOT 7
#define H_DISCOVERY 13

@interface WelcomeAlbumViewController ()

@property(strong, nonatomic) NSMutableArray *albumViewArray;
@property(strong, nonatomic) NSMutableArray *indexViewArray;
@property(strong, nonatomic) NSArray *albumList;
@property(assign, nonatomic) NSUInteger index;
@property(strong, nonatomic) UIImage *dotImage;
@property(strong, nonatomic) UIImage *dotImageSelected;
@property(strong, nonatomic) UIImage *discoveryImage;
@property(strong, nonatomic) UIImage *discoveryImageSelected;
@property(strong, nonatomic) UIImageView *logo;
@property(assign, nonatomic) CGFloat sumDx;

@end

@implementation WelcomeAlbumViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  QueryMostPopPhotoRequest *req = [[QueryMostPopPhotoRequest alloc] init];
  [req setsize:5];
  [APIManager queryMostPopPhoto:req success:^{
    [self initWelcomeAlbum];
  } failure:^{}];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self addlogo];
  self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self removeLogo];
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

- (void)initWelcomeAlbum {
  self.albumList = [DataManager mostPopPhotoArray];
  self.albumViewArray = [[NSMutableArray alloc] initWithCapacity:self.albumList.count];
  self.indexViewArray = [[NSMutableArray alloc] initWithCapacity:self.albumList.count];
  self.index = 0;
  self.sumDx = 0;
  
  for (int index = 0; index < self.albumList.count; index++) {
    AlbumInfoView *albumInfoView = [AlbumInfoView albumInfoViewWith:[self.albumList objectAtIndex:index]];
    
    [self.view addSubview:albumInfoView];
    if (index == 0) {
      [albumInfoView setFrameForShow];
    } else {
      [albumInfoView setFrameForRightHide];
    }
    
    [self.albumViewArray addObject:albumInfoView];
  }
  
  NSUInteger count = self.albumList.count;
  float length = (count * W_DOT) + ((count - 1) * X_DOT_INC) + W_DISCOVERY + X_DISCOVERY_INC;
  float startX = (320 - length) / 2;
  self.dotImage = [UIImage imageNamed:@"点不透明"];
  self.dotImageSelected = [UIImage imageNamed:@"点"];
  self.discoveryImage = [UIImage imageNamed:@"探索"];
  self.discoveryImageSelected = [UIImage imageNamed:@"探索 不透明"];
  
  
  for (int index = 0; index <= self.albumList.count; index++) {
    UIImageView *indexView = nil;
    if (index == self.albumList.count) {
      float x = startX + index*W_DOT + (index-1)*X_DOT_INC + X_DISCOVERY_INC;
      indexView = [[UIImageView alloc] initWithFrame:CGRectMake(x, Y_DISCOVERY, W_DISCOVERY, H_DISCOVERY)];
      indexView.image = self.discoveryImage;
    } else {
      float x = startX + ((index+1)*W_DOT) + index*X_DOT_INC;
      indexView = [[UIImageView alloc] initWithFrame:CGRectMake(x, Y_DOT, W_DOT, H_DOT)];
      if (index == 0) {
        indexView.image = self.dotImageSelected;
      } else {
        indexView.image = self.dotImage;
      }
    }
    [self.indexViewArray addObject:indexView];
    [self.view insertSubview:indexView atIndex:kIndexViewZIndex];
  }
}

- (void)goRight {
  [UIView animateWithDuration:0.4 animations:^{
    [[self currentAlbumView] setFrameForLeftHide];
    [[self rightAlbumView] setFrameForShow];
    [[self leftAlbumView] setFrameForLeftHide];
  } completion:^(BOOL finished){
    if (finished) {
      [self currentIndexView].image = self.dotImage;

      if ([self rightIndexView].image == self.discoveryImage) {
        [self rightIndexView].image = self.discoveryImageSelected;
        [MainToolbar goDiscovery];
      } else {
        [self rightIndexView].image = self.dotImageSelected;
      }
      
      self.index++;
    }
  }];
}

- (void)goCurrent {
  [UIView animateWithDuration:0.4 animations:^{
    [[self currentAlbumView] setFrameForShow];
    [[self rightAlbumView] setFrameForRightHide];
    [[self leftAlbumView] setFrameForLeftHide];
  } completion:^(BOOL finished){
    if (finished) {
      //Do nothing
    }
  }];
}

- (void)goLeft {
  [UIView animateWithDuration:0.4 animations:^{
    [[self currentAlbumView] setFrameForRightHide];
    [[self leftAlbumView] setFrameForShow];
    [[self rightAlbumView] setFrameForRightHide];
  } completion:^(BOOL finished){
    if (finished) {
      [self currentIndexView].image = self.dotImage;
      
      if ([self leftIndexView].image == self.discoveryImage) {
        [self leftIndexView].image = self.discoveryImageSelected;
      } else {
        [self leftIndexView].image = self.dotImageSelected;
      }
      
      self.index--;
    }
  }];
}

- (BOOL)hasLeftAlbumView {
  if (self.index == 0) {
    return NO;
  } else {
    return YES;
  }
}

- (BOOL)hasRightAlbumView {
  if (self.index == self.albumViewArray.count) {
    return NO;
  } else {
    return YES;
  }
}

- (AlbumInfoView *)leftAlbumView {
  if ([self hasLeftAlbumView]) {
    return [self.albumViewArray objectAtIndex:self.index - 1];
  } else {
    return nil;
  }
}

- (AlbumInfoView *)rightAlbumView {
  if ([self hasRightAlbumView] && (self.index < self.albumViewArray.count -1)) {
    return [self.albumViewArray objectAtIndex:self.index + 1];
  } else {
    return nil;
  }
}

- (AlbumInfoView *)currentAlbumView {
  return [self.albumViewArray objectAtIndex:self.index];
}

- (BOOL)hasLeftIndexView {
  if (self.index == 0) {
    return NO;
  } else {
    return YES;
  }
}

- (BOOL)hasRightIndexView {
  if (self.index == (self.indexViewArray.count - 1)) {
    return NO;
  } else {
    return YES;
  }
}

- (UIImageView *)leftIndexView {
  if ([self hasLeftIndexView]) {
    return [self.indexViewArray objectAtIndex:self.index - 1];
  } else {
    return nil;
  }
}

- (UIImageView *)rightIndexView {
  if ([self hasRightIndexView]) {
    return [self.indexViewArray objectAtIndex:self.index + 1];
  } else {
    return nil;
  }
}

- (UIImageView *)currentIndexView {
  return [self.indexViewArray objectAtIndex:self.index];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
  
  UITouch *touch = [touches anyObject];
  if (touch) {
    CGPoint currentLocation = [touch locationInView:touch.view];
    CGPoint previousLocation = [touch previousLocationInView:touch.view];
    CGFloat x = currentLocation.x - previousLocation.x;
    
    [[self currentAlbumView] setFrameByDeltaX:x];
    [[self rightAlbumView] setFrameByDeltaX:x];
    [[self leftAlbumView] setFrameByDeltaX:x];
    
    self.sumDx += x;
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  
  if (self.sumDx == 0) {
    [[self currentAlbumView] onClickImage];
    return;
  }
  
  if (fabsf((float)self.sumDx) <= 30) {
    [self goCurrent];
  } else if (self.sumDx < -30) {
    // go right
    if ([self hasRightAlbumView]) {
      [self goRight];
    } else {
      [self goCurrent];
    }
  } else if (self.sumDx > 30) {
    // go left
    if ([self hasLeftAlbumView]) {
      [self goLeft];
    } else {
      [self goCurrent];
    }
  }
  
  self.sumDx = 0;
}

@end
