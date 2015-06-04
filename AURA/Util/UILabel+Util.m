//
//  UILabel+Util.m
//  AURA
//
//  Created by MacMiniS on 14-10-23.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "UILabel+Util.h"

@implementation UILabel (Util)

- (void)setTextWithAutoSize:(NSString *)text maxWidth:(float)maxWidth{
  CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: self.font}];
  CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
  if (frame.size.width > maxWidth) {
    frame.size.width = maxWidth;
  }
  
  self.frame = frame;
  self.text = text;
}

@end
