//
//  PhotoTableViewCell.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "UIImageView+Util.h"
#import "DataManager.h"
#import "UIView+Util.h"
#import "NSDate+Util.h"
#import "TagLabel.h"

@interface PhotoTableViewCell ()

@property (nonatomic, strong) Photo *photo;

@end

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)initWithPhoto:(Photo *)photo {
  self.photo = photo;
  [self.photoImageView setImageeWithSha1:photo.sha1 withPlaceHolder:nil];
  self.lblInfo.text = [NSString stringWithFormat:@"%@ %@", photo.creatorinfo.nickname, [NSDate getTimeStringFrom:photo.ctime]];
  self.userImageView.image = [DataManager defaultUserImage];
  [self.userImageView setCornerRadius:20];
  [self.userImageView setBorder:1 andColor:[[UIColor whiteColor] CGColor]];
  self.lblFCount.text = photo.fcount;
  
  NSArray *tags = [self.photo.tag componentsSeparatedByString:@","];
  if (tags.count == 0) {
    self.lblTag.hidden = YES;
  } else {
    CGFloat next = 45;
    for (NSString *tag in tags) {
      TagLabel *label = [TagLabel tagLabelWithTagString:tag];
      [label setFrame:CGRectMake(next, 379, label.frame.size.width, 22)];
      next = label.frame.origin.x + label.frame.size.width + 10;
      [self.contentView addSubview:label];
    }
  }
}

- (IBAction)onClickUser:(id)sender {

}

- (IBAction)onClickLike:(id)sender {
}

- (IBAction)onClickMore:(id)sender {
}

@end
