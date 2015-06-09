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

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)initWithPhoto:(Photo *)photo {
  [self.photoImageView setImageeWithSha1:photo.sha1 withPlaceHolder:nil];
  self.lblInfo.text = [NSString stringWithFormat:@"%@ %@", photo.creatorinfo.nickname, [NSDate getTimeStringFrom:photo.ctime]];
  self.userImageView.image = [DataManager defaultUserImage];
  [self.userImageView setCornerRadius:20];
  [self.userImageView setBorder:1 andColor:[[UIColor whiteColor] CGColor]];
}

- (IBAction)onClickUser:(id)sender {

}

@end
