//
//  AlbumPhotoCell.h
//  AURA
//
//  Created by MacMiniS on 14-10-30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface AlbumPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblFcount;
@property (weak, nonatomic) IBOutlet UILabel *lblCtime;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) UITableViewController *supperController;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

- (void)initWithPhoto:(Photo *)photo andIndexPath:(NSIndexPath *)indexPath;

@end
