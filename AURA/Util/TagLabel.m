//
//  TagLabel.m
//  AURA
//
//  Created by KindAzrael on 14/11/18.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "TagLabel.h"
#import "UIView+Util.h"

@implementation TagLabel

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setCornerRadius:10];
    [self setBorder:1 andColor:[[UIColor darkGrayColor] CGColor]];
    [self setTextColor:[UIColor darkGrayColor]];
    [self setTextAlignment:NSTextAlignmentCenter];
    [self setFont:[UIFont systemFontOfSize:13]];
  }
  
  return self;
}

+ (instancetype)tagLabelWithTagString:(NSString *)tag {
  CGFloat width = [TagLabel calcTagLength:tag];
  TagLabel *label = [[TagLabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
  [label setText:tag];
  return label;
}

+ (CGFloat)calcTagLength:(NSString *)tagText {
  CGSize size = [tagText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
  return size.width + 16;
}

@end
