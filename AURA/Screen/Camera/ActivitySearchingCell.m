//
//  ActivitySearchingCell.m
//  AURA
//
//  Created by MacMiniS on 15-3-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "ActivitySearchingCell.h"

@implementation ActivitySearchingCell

- (void)awakeFromNib {
    // Initialization code
//  CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//  rotationAnimation.toValue = [NSNumber numberWithFloat:-M_PI * 2.0];
//  rotationAnimation.duration = 1;
//  rotationAnimation.repeatCount = HUGE_VALF;
// 
//  [self.indicator.layer addAnimation:rotationAnimation forKey:@"rotation"];
  [self.activityIndicator startAnimating];
}

@end
