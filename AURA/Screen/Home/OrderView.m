//
//  OrderView.m
//  AURA
//
//  Created by MacMiniS on 15-4-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "OrderView.h"

@implementation OrderView

+ (OrderView *)orderView {
  return [[[NSBundle mainBundle] loadNibNamed:@"OrderView" owner:nil options:nil] lastObject];
}

@end
