//
//  UserCenterCellCell.h
//  AURA
//
//  Created by KindAzrael on 15/7/12.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterCellCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblSignature;
@property (weak, nonatomic) IBOutlet UILabel *lblPicCount;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *lblFcount;
@property (weak, nonatomic) IBOutlet UILabel *lblFolloweeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblFollowerCount;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *userBackgroundImageView;

@property (strong, nonatomic) NSString *userId;

- (void)initDisplay;

@end
