//
//  LicenseViewController.m
//  AURA
//
//  Created by KindAzrael on 15/4/25.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "LicenseViewController.h"

@interface LicenseViewController ()

@end

@implementation LicenseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self initNav];
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.title = @"服务条款";
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
