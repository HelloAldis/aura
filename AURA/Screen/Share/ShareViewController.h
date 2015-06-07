//
//  ShareViewController.h
//  AURA
//
//  Created by MacMiniS on 15-3-17.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIImage *image;

@end
