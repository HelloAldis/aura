//
//  ActivitySearchingCell.h
//  AURA
//
//  Created by MacMiniS on 15-3-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitySearchingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *indicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@end
