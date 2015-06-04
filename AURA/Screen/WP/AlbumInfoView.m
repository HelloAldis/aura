//
//  WelcomeAlbumView.m
//  AURA
//
//  Created by KindAzrael on 14-9-27.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AlbumInfoView.h"
#import "AURADefines.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"
#import "AURA.h"
#import "ViewControllerContainer.h"

@interface AlbumInfoView ()

@property (weak, nonatomic) IBOutlet UILabel *lblPeopleCount;
@property (weak, nonatomic) IBOutlet UILabel *lblPictureCount;
@property (weak, nonatomic) IBOutlet UILabel *lblLikeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityName;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *panel;
@property (weak, nonatomic) IBOutlet UIView *categoryView;

@property (nonatomic, strong) Photo *photo;

@end

@implementation AlbumInfoView

+ (id)albumInfoViewWith:(Photo *)photo {
  AlbumInfoView *w = [[[NSBundle mainBundle] loadNibNamed:@"AlbumInfoView" owner:nil options:nil] lastObject];
  w.lblActivityName.text = [[photo albuminfo] name];
  w.lblPeopleCount.text = photo.albuminfo.jcount;
  w.lblPictureCount.text = @"";
  w.lblLikeCount.text = [photo fcount];
  w.lblCity.text = photo.city;
  [w.imageView setCornerRadius:5];
  [w.panel setCornerRadius:5];
  [w.imageView setImageeWithSha1:photo.sha1 withPlaceHolder:nil];
  w.categoryView.backgroundColor = [AURA getColorByType:[[photo albuminfo] type]];
  
  w.photo = photo;
  return w;
}

- (void)setFrameForShow {
  self.frame = CGRectMake(0, 0, 320, 457);
}

- (void)setFrameForLeftHide {
  self.frame = CGRectMake(-320, 0, 320, 457);
}

- (void)setFrameForRightHide {
  self.frame = CGRectMake(320, 0, 320, 457);
}

- (void)setFrameByDeltaX:(CGFloat)deltaX {
  self.frame = CGRectMake(self.frame.origin.x + deltaX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (IBAction)onClickImage:(id)sender {
  [ViewControllerContainer showAlbumDetail:self.photo.albuminfo];
}

- (void)dealloc {
  DDLogDebug(@"AlbumInfoView dealloc");
}

@end
