//
//  WelcomeAlbumView.h
//  AURA
//
//  Created by KindAzrael on 14-9-27.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface AlbumInfoView : UIView

+ (id)albumInfoViewWith:(Photo *)photo;
- (void)setFrameForShow;
- (void)setFrameForLeftHide;
- (void)setFrameForRightHide;
- (void)setFrameByDeltaX:(CGFloat)deltaX;
- (void)onClickImage;

@end
