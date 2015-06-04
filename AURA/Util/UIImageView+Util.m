//
//  UIImageView+Util.m
//  AURA
//
//  Created by KindAzrael on 14/11/9.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "UIImageView+Util.h"
#import "NSDate+Util.h"
#import "CryptoUtil.h"

@implementation UIImageView (Util)

- (void)setImageeWithSha1:(NSString *)sha1 withPlaceHolder:(UIImage *)holder {
  NSString *date = [NSDate get10MinAfterNow];
  NSString *signature = [CryptoUtil signatureMethod:GET_METHOD withDate:date withName:[NSString stringWithFormat:@"/aura/%@", sha1]];
  NSString *url = [NSString stringWithFormat:@"http://aura.oss.aliyuncs.com/%@?OSSAccessKeyId=%@&Expires=%@&Signature=%@", sha1, AccessID, date, signature];

  [self sd_setImageWithURL:[NSURL URLWithString:url]];
}

@end
