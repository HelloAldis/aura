//
//  UIImage+Util.m
//  AURA
//
//  Created by KindAzrael on 14/10/30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

- (NSData *)data {
  return UIImageJPEGRepresentation(self, 0.7);
}

- (UIImage *)getSubImage:(CGRect)rect {
//  UIGraphicsBeginImageContext(rect.size);
//  [self drawInRect:rect];
//  UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
//  UIGraphicsEndImageContext();
  DDLogDebug(@"o size : %lu", (unsigned long)[self data].length);
  
  
  CGImageRef cImage = CGImageCreateWithImageInRect(self.CGImage, rect);
  UIImage *smallImage = [UIImage imageWithCGImage:cImage scale:self.scale orientation:self.imageOrientation];
  CGImageRelease(cImage);
  
  if (rect.size.width > 640) {
    rect = CGRectMake(0, 0, 640, 640);
  } else {
    rect = CGRectMake(0, 0, rect.size.width, rect.size.height);
  }

  UIGraphicsBeginImageContext(rect.size);
  [smallImage drawInRect:rect];
  smallImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  DDLogDebug(@"new size : %lu", (unsigned long)[smallImage data].length);
  
  return smallImage;
}

- (UIImage *)getSquareImage {
  CGFloat height = self.size.height;
  CGFloat width = self.size.width;
  
  if (fabs(height - width) < 0.01) {
    return self;
  }
  
  CGFloat square = height > width ? width : height;
  
  return [self getSubImage:CGRectMake(0, 0, square, square)];
}

- (UIImage *)getCenterSquareImage {
  CGFloat height = self.size.height;
  CGFloat width = self.size.width;
  
  if (fabs(height - width) < 0.01) {
    return self;
  }
  
  if (height > width) {
    float y = (height - width) / 2.0;
    return [self getSubImage:CGRectMake(0, y, width, width)];
  } else {
    float x = (width - height) / 2.0;
    return [self getSubImage:CGRectMake(x, 0, height, height)];
  }
}

@end