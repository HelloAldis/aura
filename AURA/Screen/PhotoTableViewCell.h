//
//  PhotoTableViewCell.h
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

- (void)initWithPhoto:(Photo *)photo;

@end
