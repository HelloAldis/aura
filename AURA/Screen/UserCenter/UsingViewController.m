//
//  UsingViewController.m
//  AURA
//
//  Created by KindAzrael on 15/4/25.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "UsingViewController.h"

@interface UsingViewController ()

@end

@implementation UsingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self initNav];
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.title = @"AURA使用指南";
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
