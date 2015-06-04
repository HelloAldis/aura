//
//  ActivityCellTableViewCell.m
//  AURA
//
//  Created by MacMiniS on 15-3-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "ActivityCell.h"
#import "AURA.h"
#import "APIDefines.h"
#import "DataManager.h"
#import "NSDate+Util.h"

@interface ActivityCell ()

@property (nonatomic, strong) Photo *photo;

@end

@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initWithPhoto:(Photo *)photo {
  self.photo = photo;
  
  self.category.backgroundColor = [AURA getColorByType:photo.albuminfo.type];
  self.userImageView.image = [DataManager defaultUserImage];
  self.lblCtime.text = [NSDate getTimeStringFrom:photo.ctime] ;
  self.lblAlbumName.text = photo.albuminfo.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  if (selected) {
    self.contentView.backgroundColor = [AURA getBackgroundColorByType:self.photo.albuminfo.type];
    self.category.backgroundColor = [AURA getColorByType:self.photo.albuminfo.type];
  } else {
    self.contentView.backgroundColor = [UIColor clearColor];
  }
}

@end
