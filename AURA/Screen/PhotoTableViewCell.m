//
//  PhotoTableViewCell.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "UIImageView+Util.h"

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)initWithPhoto:(Photo *)photo {
  [self.photoImageView setImageeWithSha1:photo.sha1 withPlaceHolder:nil];
}

@end
