//
//  ShareActivityCell.h
//  AURA
//
//  Created by KindAzrael on 15/3/29.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface ShareActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *category;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *info;

- (void)initWithPhoto:(Photo *)photo;

@end
