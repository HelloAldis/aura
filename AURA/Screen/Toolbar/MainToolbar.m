//
//  MainToolbar.m
//  AURA
//
//  Created by KindAzrael on 14-9-25.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "MainToolbar.h"
#import "AppDelegate.h"
#import "TagDefines.h"
#import "AURADefines.h"
#import "ViewControllerContainer.h"

#define kColorSelected [UIColor colorWithRed:5.0f/255 green:5.0f/255 blue:5.0f/255 alpha:1.0f]
#define kColorUnselected [UIColor clearColor]
#define kShowFrame CGRectMake(0, 521, 320, 47)
#define kHideFrame CGRectMake(0, 571, 320, 47)
#define kHideDiff 50

typedef enum : NSUInteger {
  NoneIndex,
  HomeIndex,
  UserCenterIndex,
  DiscoveryIndex
} MainToolbarIndex;

@interface MainToolbar ()

@property(strong, nonatomic) AwesomeMenu *menu;
@property(assign, nonatomic) MainToolbarIndex index;
@property (weak, nonatomic) IBOutlet UIImageView *home;
@property (weak, nonatomic) IBOutlet UIImageView *userCenter;
@property (weak, nonatomic) IBOutlet UIButton *btnFrist;
@property (weak, nonatomic) IBOutlet UIButton *btnSecond;
@property (weak, nonatomic) IBOutlet UIView *discoveryBackground;

@end

@implementation MainToolbar

static MainToolbar *toolbar = nil;

+ (MainToolbar *)mainToolBar {
  if (toolbar == nil) {
    toolbar = [[[NSBundle mainBundle] loadNibNamed:@"MainToolbar" owner:nil options:nil] lastObject];
    toolbar.frame = kShowFrame;
    toolbar.tag = kMainToolBarTag;
    toolbar.index = NoneIndex;
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"camera icon未选中"]
                                                           highlightedImage:[UIImage imageNamed:@"camera icon "]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"探索 icon未选中"]
                                                           highlightedImage:[UIImage imageNamed:@"探索icon "]
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, nil];
    
    UIImage *image = [UIImage imageNamed:@"icon a"]; // icon a a选中态
    
    AwesomeMenuItem *startItem =
    [[AwesomeMenuItem alloc] initWithImage:image
                          highlightedImage:nil
                              ContentImage:nil
                   highlightedContentImage:nil];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:toolbar.frame startItem:startItem optionMenus:menus];
    menu.delegate = toolbar;
    
    menu.menuWholeAngle = M_PI / 3;
    menu.rotateAngle = -(M_PI / 6);
    menu.farRadius = 110.0f;
    menu.endRadius = 100.0f;
    menu.nearRadius = 90.0f;
    menu.animationDuration = 0.3f;
    menu.closeRotation = 0;
    menu.rotateAddButton = NO;
    
    menu.startPoint = CGPointMake(160, 23);
    
    toolbar.menu = menu;
  }
  
  return toolbar;
}

+ (void)clearToolbar {
  toolbar.index = NoneIndex;
  toolbar.home.image = [UIImage imageNamed:@"home"];
  toolbar.userCenter.image = [UIImage imageNamed:@"personal center icon "];
  toolbar.btnFrist.backgroundColor = kColorUnselected;
  toolbar.btnSecond.backgroundColor = kColorUnselected;
  toolbar.discoveryBackground.backgroundColor = kColorUnselected;
}

+ (void)showMainToolbar {
  MainToolbar *toolbar = [MainToolbar mainToolBar];
  if ([[AppDelegate sharedInstance].window viewWithTag:kMainToolBarTag] == nil) {
    [[AppDelegate sharedInstance].window insertSubview:toolbar atIndex:kToolbarZIndex];
    [[AppDelegate sharedInstance].window insertSubview:toolbar.menu aboveSubview:toolbar];
  } else {
    [UIView animateWithDuration:0.3 animations:^{
      toolbar.frame = kShowFrame;
      toolbar.menu.alpha = 1;
    }];
  }
}

+ (void)bringToolbarToFront {
  MainToolbar *toolbar = [MainToolbar mainToolBar];
  [[AppDelegate sharedInstance].window bringSubviewToFront:toolbar];
  [[AppDelegate sharedInstance].window bringSubviewToFront:toolbar.menu];
}

+ (void)clickSecond {
  MainToolbar *toolbar = [MainToolbar mainToolBar];
  [toolbar onBtnSecondClick:nil];
}

+ (void)hideMainToolbar {
  MainToolbar *toolbar = [MainToolbar mainToolBar];
  [UIView animateWithDuration:0.3 animations:^{
    toolbar.frame = kHideFrame;
    toolbar.menu.alpha = 0;
  }];
}

+ (void)setDelegate:(id<MainToolbarDelegate>)delegate {
  MainToolbar *toolbar = [MainToolbar mainToolBar];
  toolbar.delegate = delegate;
}

- (IBAction)onBtnFirstClick:(id)sender {
  if (self.index == HomeIndex) {
    return;
  }
  
  [self.delegate onBtnFirstClick];
  self.index = HomeIndex;
  self.home.image = [UIImage imageNamed:@"选中 home"];
  self.userCenter.image = [UIImage imageNamed:@"personal center icon "];
  self.btnFrist.backgroundColor = kColorSelected;
  self.btnSecond.backgroundColor = kColorUnselected;
  self.discoveryBackground.backgroundColor = kColorUnselected;
  [self setAImage];
  
  [ViewControllerContainer showHome];
}

- (IBAction)onBtnSecondClick:(id)sender {
  if (self.index == UserCenterIndex) {
    return;
  }
  
  [self.delegate onBtnSecondClick];
  self.index = UserCenterIndex;
  self.home.image = [UIImage imageNamed:@"home"];
  self.userCenter.image = [UIImage imageNamed:@"选中personal center icon "];
  self.btnSecond.backgroundColor = kColorSelected;
  self.btnFrist.backgroundColor = kColorUnselected;
  self.discoveryBackground.backgroundColor = kColorUnselected;
  [self setAImage];
  
  [ViewControllerContainer showMyCenter];
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx {
  switch (idx) {
    case 0:
      
      [ViewControllerContainer showCameraViewController];
      [self setAImage];
      break;
    case 1:
      [self goDiscoveryScreen];
      break;
    default:
      break;
  }
}

+ (void)goDiscovery {
  MainToolbar *toolbar = [MainToolbar mainToolBar];
  [toolbar goDiscoveryScreen];
}

- (void)goDiscoveryScreen {
  [self setDiscoveryImage];
  self.discoveryBackground.backgroundColor = kColorSelected;
  self.btnSecond.backgroundColor = kColorUnselected;
  self.btnFrist.backgroundColor = kColorUnselected;
  self.home.image = [UIImage imageNamed:@"home"];
  self.userCenter.image = [UIImage imageNamed:@"personal center icon "];
  [ViewControllerContainer showDiscouvery];
  self.index = DiscoveryIndex;
}

- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
  DDLogDebug(@"awesomeMenuDidFinishAnimationClose");
}

- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
  DDLogDebug(@"awesomeMenuDidFinishAnimationOpen");
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu {
  DDLogDebug(@"awesomeMenuWillAnimateOpen");
  [self setGrayAImage];
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu {
  DDLogDebug(@"awesomeMenuWillAnimateClose");
  [self setAImage];
}

- (void)setDiscoveryImage {
  self.menu.image = [UIImage imageNamed:@"探索 icon未选中"];
}

- (void)setAImage {
  self.menu.image = [UIImage imageNamed:@"icon a"];
}

- (void)setGrayAImage {
  self.menu.image = [UIImage imageNamed:@"a选中态"];
}

@end
