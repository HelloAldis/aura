//
//  CommentTableViewCell.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "DataManager.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithComment:(Comment *)comment {
  self.lblComment.text = comment.comment;
  self.lblUser.text = comment.from_user.nickname;
  [self.userImageView setUserImageWithSha1:comment.from_user.thumbnail];
  [self.userImageView setCornerRadius:15];
  [self.userImageView setBorder:1 andColor:[[UIColor whiteColor] CGColor]];
}

@end
