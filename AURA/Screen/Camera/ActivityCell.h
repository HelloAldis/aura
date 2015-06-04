//
//  ActivityCellTableViewCell.h
//  AURA
//
//  Created by MacMiniS on 15-3-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *category;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblCtime;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbumName;

- (void)initWithPhoto:(Photo *)photo;

@end
