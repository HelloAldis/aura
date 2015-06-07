//
//  TagTableViewCell.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "TagTableViewCell.h"
#import "TagLabel.h"

@implementation TagTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithTags:(NSArray *)tags {
  CGFloat next = 10;
  for (NSString *tag in tags) {
    TagLabel *label = [TagLabel tagLabelWithTagString:tag];
    [label setFrame:CGRectMake(next, 35, label.frame.size.width, 22)];
    next = label.frame.origin.x + label.frame.size.width + 10;
    [self.contentView addSubview:label];
  }
}

@end
