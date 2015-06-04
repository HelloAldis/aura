//
//  UIImageView+Util.h
//  AURA
//
//  Created by KindAzrael on 14/11/9.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (Util)

- (void)setImageeWithSha1:(NSString *)sha1 withPlaceHolder:(UIImage *)holder;


@end
