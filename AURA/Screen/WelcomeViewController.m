//
//  WelcomeViewController.m
//  AURA
//
//  Created by KindAzrael on 15/7/19.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "WelcomeViewController.h"
#import "DataManager.h"
#import "ViewControllerContainer.h"
#import "NSDate+Util.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *first;
@property (weak, nonatomic) IBOutlet UIImageView *second;
@property (weak, nonatomic) IBOutlet UIImageView *thired;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger sumDx;
@property (nonatomic, strong) NSArray *views;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.sumDx = 0;
  self.index = 0;
  self.views = @[self.first, self.second, self.thired];
  
  [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (UIImageView *)currentView {
  return [self.views objectAtIndex:self.index];
}

- (UIImageView *)leftView {
  if (self.index >= 1) {
    return [self.views objectAtIndex:self.index - 1];
  } else {
    return nil;
  }
}

- (UIImageView *)rightView {
  if (self.index <= self.views.count - 2) {
    return [self.views objectAtIndex:self.index + 1];
  } else {
    return nil;
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
  
  UITouch *touch = [touches anyObject];
  if (touch) {
    CGPoint currentLocation = [touch locationInView:touch.view];
    CGPoint previousLocation = [touch previousLocationInView:touch.view];
    CGFloat x = currentLocation.x - previousLocation.x;
    
    [self currentView].frame = CGRectOffset([self currentView].frame, x, 0);
    [self rightView].frame = CGRectOffset([self rightView].frame, x, 0);
    [self leftView].frame = CGRectOffset([self leftView].frame, x, 0);
    
    self.sumDx += x;
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  
  if (fabsf((float)self.sumDx) <= 30) {
    [self goCurrent];
  } else if (self.sumDx < -30) {
    // go right
    if ([self rightView] != nil) {
      [self goRight];
    } else {
      if ([NSDate is10DayBeforeNow:[DataManager tokenDate]]) {
        [ViewControllerContainer showLoginViewController];
      } else {
        [ViewControllerContainer showWPViewController];
      }
    }
  } else if (self.sumDx > 30) {
    // go left
    if ([self leftView] != nil) {
      [self goLeft];
    } else {
      [self goCurrent];
    }
  }
  
  self.sumDx = 0;
}

- (void)leftHide:(UIImageView *)view {
  view.frame = CGRectMake(-320, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
}

- (void)show:(UIImageView *)view {
  view.frame = CGRectMake(0, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
}

- (void)rightHide:(UIImageView *)view {
  view.frame = CGRectMake(320, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
}

- (void)goRight {
  [UIView animateWithDuration:0.4 animations:^{
    [self leftHide:[self currentView]];
    [self show:[self rightView]];
    [self leftHide:[self leftView]];
  } completion:^(BOOL finished){
    if (finished) {
      self.index++;
      self.pageControl.currentPage = self.index;
    }
  }];
}

- (void)goCurrent {
  [UIView animateWithDuration:0.4 animations:^{
    [self show:[self currentView]];
    [self rightHide:[self rightView]];
    [self leftHide:[self leftView]];
  } completion:^(BOOL finished){
    if (finished) {
      //Do nothing
    }
  }];
}

- (void)goLeft {
  [UIView animateWithDuration:0.4 animations:^{
    [self show:[self leftView]];
    [self rightHide:[self currentView]];
    [self rightHide:[self rightView]];
  } completion:^(BOOL finished){
    if (finished) {
      self.index--;
      self.pageControl.currentPage = self.index;
    }
  }];
}


@end
