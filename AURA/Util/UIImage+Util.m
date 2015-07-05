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
  NSData *data = nil;
  if (self.size.width > 640) {
    CGRect rect = CGRectMake(0, 0, 640, 640);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    data = UIImageJPEGRepresentation(img, 0.7);
  } else {
    data = UIImageJPEGRepresentation(self, 0.7);
  }
  
  DDLogDebug(@"data bytes %ld", [data length]);
  
  return data;
}

- (UIImage *)getSubImage:(CGRect)rect {
  CGImageRef cImage = CGImageCreateWithImageInRect(self.CGImage, rect);
  UIImage *smallImage = [UIImage imageWithCGImage:cImage scale:self.scale orientation:self.imageOrientation];
  CGImageRelease(cImage);
  
//  if (rect.size.width > 640) {
//    rect = CGRectMake(0, 0, 640, 640);
//  } else {
    rect = CGRectMake(0, 0, rect.size.width, rect.size.height);
//  }

  UIGraphicsBeginImageContext(rect.size);
  [smallImage drawInRect:rect];
  smallImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
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