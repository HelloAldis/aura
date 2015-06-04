//
//  OrderView.h
//  AURA
//
//  Created by MacMiniS on 15-4-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btnOrderFCount;
@property (weak, nonatomic) IBOutlet UIButton *btnOrderByTIme;

+ (OrderView *)orderView;

@end
