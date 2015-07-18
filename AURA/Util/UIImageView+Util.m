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
#import "DataManager.h"

@implementation UIImageView (Util)

- (void)setImageeWithSha1:(NSString *)sha1 withPlaceHolder:(UIImage *)holder {
  NSString *date = [NSDate get10MinAfterNow];
  NSString *signature = [CryptoUtil signatureMethod:GET_METHOD withDate:date withName:[NSString stringWithFormat:@"/aura/%@", sha1]];
  NSString *url = [NSString stringWithFormat:@"http://aura.oss.aliyuncs.com/%@?OSSAccessKeyId=%@&Expires=%@&Signature=%@", sha1, AccessID, date, signature];

  [self sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (void)setUserImageWithSha1:(NSString *)sha1 {
  if ([sha1 isEqual:[NSNull null]] || sha1.length == 0 || [[sha1 lowercaseString] isEqualToString:@"none"]) {
    self.image = [DataManager defaultUserImage];
    //00000055ee9148cba9d83fa1629c074b
//    [self setImageeWithSha1:@"3db01f383c9a6c6548482058d58556ada3b51c16" withPlaceHolder:nil];
  } else {
    [self setImageeWithSha1:sha1 withPlaceHolder:nil];
  }
}

@end
