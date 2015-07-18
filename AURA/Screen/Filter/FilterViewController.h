//
//  FilterViewController.h
//  AURA
//
//  Created by MacMiniS on 14-10-27.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "BaseViewController.h"

#define TYPE_EDIT_IMAGE 0
#define TYPE_EDIT_USER  1

@interface FilterViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIImage *orignalImage;
@property (assign, nonatomic) NSInteger type;

@end
