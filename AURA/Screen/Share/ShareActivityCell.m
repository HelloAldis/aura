//
//  ShareActivityCell.m
//  AURA
//
//  Created by KindAzrael on 15/3/29.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "ShareActivityCell.h"
#import "APIDefines.h"
#import "AURA.h"
#import "DataManager.h"
#import "NSDate+Util.h"

@interface ShareActivityCell ()

@property (nonatomic, strong) Photo *photo;

@end

@implementation ShareActivityCell

- (void)awakeFromNib {
    // Initialization code
  self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)initWithPhoto:(Photo *)photo {
  self.photo = photo;
  
  self.category.backgroundColor = [AURA getColorByType:photo.albuminfo.type];
  self.userImageView.image = [DataManager defaultUserImage];
  self.info.text = [NSDate getTimeStringFrom:photo.ctime];
  self.title.text = self.photo.albuminfo.name;
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
