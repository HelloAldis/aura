//
//  AlbumInfoCell.h
//  AURA
//
//  Created by MacMiniS on 14-10-30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumInfo.h"
#import "Photo.h"

@interface AlbumInfoCell : UITableViewCell

@property (weak, nonatomic) UITableViewController *supperController;

- (void)initwithAlbumInfo:(AlbumInfo *)albumInfo andFirstImage:(Photo *)photo;

@end
