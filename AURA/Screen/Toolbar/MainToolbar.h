//
//  MainToolbar.h
//  AURA
//
//  Created by KindAzrael on 14-9-25.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AwesomeMenu.h"

@protocol MainToolbarDelegate <NSObject>

@optional
- (void)onBtnFirstClick;
- (void)onBtnSecondClick;
- (void)onCameraClick;
- (void)OnExploreClck;

@end

@interface MainToolbar : UIView <AwesomeMenuDelegate>

@property(assign, nonatomic) id<MainToolbarDelegate> delegate;

+ (void)showMainToolbar;
+ (void)setDelegate:(id<MainToolbarDelegate>)delegate;
+ (void)hideMainToolbar;
+ (void)bringToolbarToFront;
+ (void)clickSecond;
+ (void)clearToolbar;

@end
