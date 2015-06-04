//
//  FilterViewController.h
//  AURA
//
//  Created by MacMiniS on 14-10-27.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseViewController.h"

@interface FilterViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UIImage *orignalImage;

@end
